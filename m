Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056C5CA6009
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 22:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9069E6083B;
	Wed,  7 Oct 2026 22:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TkJG1YutbpeM; Wed,  7 Oct 2026 22:16:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9F4AB60819
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411381;
	b=D54CYvzFvIw9Oo78bwU8davc8vqHJjAo2tssSevaLY7IGEx59sJDY6laJsFIZBLSKPcp
	 BSwCBdOe1Q65FsNE/lV8FjSZ0/cXyKXtxwpr+ucy8cpPnwXfbRfOroOGZTAAFWGhMz3dW
	 q4RR5MuBc4wR9SOHdlnaFMCfMmvV0plsvhvs/p1LCg9oFtbN1CnzeV5PZsshqwBw3LdER
	 lqti77hO8FptIkr0ecU7m1WLHHVI7Qwbm6no6uR/EGDpC+GBtCkfJjbEvuFsvIGKi4MtF
	 e5Mgf6TB4L1cmSpy9dw0+0Bh5OXZJq7HI8tuXCNKPC5ekwq4K2ccKEnxjM+XFOJlqsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791411381;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wTL/r7ZbdfdYcMyKadYh0J1UokcErMkjm4qy+oOvwqs=;
	b=b5+wuxwbvpGV8RM82vodu0IIt8Av04UIh7pKDACTr+/futvs4uPrFAKTZ6OFIgwIzaSD
	 YWsx4CtovbBqGl3oO2XnmkwH05vH6zrTD326hmFx0rvsotJaxy0aPzXh6M4xnQ+vEFS/z
	 RUF3CQX7H15yhq9osYaKt6g6/9wx2aMQkLZqBtXs9jXLVJg/VPkdnpvttfh14s06qMjeJ
	 weQTY2Yxx9dW+Jn6mm2dfLHCi8O5wym9V0C+rJIPO727THugfmO+xEdfjSUp6zYU4ax4x
	 7pf2EAVJCP30wPk4aJ+spoKHS/1kdzDUv4S3AR18+AI6CO60mDh9oF0/MY39TdT31Ew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791411381;
	bh=wTL/r7ZbdfdYcMyKadYh0J1UokcErMkjm4qy+oOvwqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DpoNo3DPvkimT+aeyRnF1MHuBkd6P01odZ9t7Hm4vRSxlRVCY1d5IKVgXLsjbNjsk
	 yEbZMG2anMnuEhtpzbxDgCT9VcdSJJsKedlxF82fllqxbj8GzD/sUfGt6QZh+couqQ
	 a6r0uGLB8E08Omdzt9DbHpqWFEveYe75LJlqaDetIz6J/0fBWKeycdKWzk9t9Nu6X8
	 l/yiVO8ELF4KMuj38ySgxLR+70KzxXEF3sSF6krcK2hHWMjESsIFdhxLpYL+aLe85K
	 ph64Lk375LIGXeXA+kpdF1vWta6MKW6UKVi/prRidw8yiAICZSv4EkdbzpLadewy01
	 LgWfTb7vTtXCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F4AB60819;
	Wed,  7 Oct 2026 22:16:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AA7F338
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 70C66400BE
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:30:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3BjBqFMmM5xW for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 20:30:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 96A234004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791405018;
 b=cKOq5aZg3CfbUs6LakOkUKrk86J7/Kt51bfM6e4r8ttMxbKxcIih3NhPv48umQqBn1dp
 jukArkJE6rBc3Qx00qJCnNqAgaQXVt8nz2/+rCvUPbAMzxDG9oUqA4BNxrTwxtmS5E0nA
 /9BpAmf/B2+RTc5w9Qn4fiN3Vtx2bywBVNy+WdDk+r6YoWkYzXfM6NRlFkpQc97/ftjvE
 LjxOZNPCRYPhbbE5HfA9L7N6gh9LavwrhJOoO8O/afGak+juRgzzXflJ2Ws00umOsrlnY
 86VmmUyJeCanpVGfr4ei88zcpcq05urxdAdVMdEPP6NwmAV/mhnEOrgGOu1Kep1pZqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791405018;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=wTL/r7ZbdfdYcMyKadYh0J1UokcErMkjm4qy+oOvwqs=;
 b=KNgVleZdkkqInDFSsZd9cepZiw2eLcMJ/m7svlcP6ReNSDrbXIS+58bOM9eT0xz3KEW9
 inTwKmGLASohwTbRbAS/B9ZXDmC32Pm1z0FvwKuSDLpWj1xirzSBlvTTo+bi476SLCm53
 MMXIySE001N0yMdmhNP/7Xp/WipiMlQ27WuMm/ZYNqB9rI+UHP62tYFZjrt7UBc92srC0
 RJ9Lr5ytQIs1p3/oMsVnwLCm7+DrvzGxQGBcArqsmJUzjkpdeUl2uyDOP2gzeRkkfSqE3
 joaXfkBDKYdO8Ge3YzHO1d/Bbg3mCXlepbpF1URPL7ytJzzPMcGMqQmFwiPfOqxHCNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="WHnv2/JH"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WHnv2/JH
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 96A234004A
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:30:18 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8874539bccbso2261090b3a.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791405017; x=1792009817;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wTL/r7ZbdfdYcMyKadYh0J1UokcErMkjm4qy+oOvwqs=;
 b=WHnv2/JHR97tTCpvq2Ojkf/9A56fPYye/dGccKvitoNWthaYUDGktkELgkTEMvRVLw
 K/WLJgJqFEHwcGD6PoODO6jE34HZjRcMpTyRW8ctWflCtV2lwFow6Z+iWHjHnkvQItk6
 TFjgxjmAFjBkMYg77kMfEfkCjXg5c9118UPHUwgKOYN5GShPbXlhLoYGQWmRwpSobC25
 PwnOpqgBlaSoleimKKyJBn6ojZ1l/3bpp2IANVhzW7ImELDXQ/9DA2puSbPgus9OkfNN
 XfqZ+1NXZCu1QdNU0JBZ+adrUP7tvvEpxUQSscwZU0TI4jvo2vwrRIbO5DsaKfQAv0VM
 osTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791405017; x=1792009817;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wTL/r7ZbdfdYcMyKadYh0J1UokcErMkjm4qy+oOvwqs=;
 b=1PRD4IYb3BzgTA31lsuOcMAf9p/btH7NTBO78pQEKUNV8ehq6w9Bjng6VyOG27qaeJ
 TPEC9vdT1OLYD5WR6i0d6G6BM321LIgTCjSl7RARtZg0PMyhYnGWqnn5sc4s2JYw1KKG
 Ze+UpQYocG58zEH+dPxqt1PsXajf0C06d9eHkUNQynqtq71+j+WWSnbq70XDt6FpJywn
 NqyMM+4uZt+qifkkijD13TQhySc4b0INSo/rh3R8/P0owENKKZl9I8CvnblTm+ejjBny
 SB38BFICF+KBDWzbtp/tmcLcHAFySq4lnqBfzXYR6lC91BlJlOSnEbJADm4w/5OrX+8H
 KTbw==
X-Forwarded-Encrypted: i=1;
 AKwUvByMhGPpzOnoGcn0369+ZAgKas8AtoQyVWFzRigVlJVNFaRrnMVuvhl3c5+yqs7vVsn1Jk9ccSk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mr7zsdKhBPDCyLNVzN7p+QfulrhLqs92ruiCZZLyEClWQ5Me6u
 cHAJRRGUYHslmiuLqqJPCKxkEAKNUvXvbWLWekm4F7LGUdHc3GAi9hQg
X-Gm-Gg: AYBFou3Yar4GFU4EUnOV7H3YU3sjak7fzYRDZ9hni3HsIiCzzG4b1cZk2/u3aKYFPG8
 lxvLHVoAoVTcLzOIqjM3GbXRSlTbQuhWmXE9vDI+ZPdNUWOL89sgg3KwSZzvCreBplgWFjbhb+j
 aZxmgYFOs2vVk9DPK7oYceeT8x4xug7zhb6UDGtisCBhKpQoBeYfjZivrQXU9M6JAdBw6luhJCy
 Cnq4oGKpmIo6R443FRmBXTgH3IwuLMGzcFq6bAmYoDa4M3EdJgjaLGT5TJ+hbZKifKDwjzVvfj/
 w52xoX6BEuBEUju4wfRqEcQRmIbFIyVqf5bn83b1wbvbuABrwN1VcY1zgavOGD7iJM/fb83PIu6
 twEhkmxb1UlSSW8myn2EPL6OkTqDUI2KPSZMPJtZoh48n8rwFf8Ib5c3ZcyBkqpcifcRLkVH5fo
 Tpy6DtZeJgypCm9VKWe+I9/aN/bOX3jQzWaI7XDpuSTTmEefj0CTdck/gOYRCI8T2xbefVqu4=
X-Received: by 2002:a05:6a00:408c:b0:885:ead7:1ca9 with SMTP id
 d2e1a72fcca58-891b2b6e70amr2937410b3a.54.1791405017558; 
 Wed, 07 Oct 2026 13:30:17 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-892bb69b94bsm782782b3a.38.2026.10.07.13.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 13:30:16 -0700 (PDT)
Date: Thu, 8 Oct 2026 04:30:12 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, sjg@chromium.org,
 jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 0/6] fs: Add 9P filesystem support over virtio
Message-ID: <asar1Es-MIxmnyM_@google.com>
References: <20260923213002.1070404-1-visitorckw@gmail.com>
 <179139852309.3398671.7231524378185570223.b4-ty@konsulko.com>
 <20261007195951.GE3079290@bill-the-cat>
 <asan7VeJ7QoRDWKq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asan7VeJ7QoRDWKq@google.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

On Thu, Oct 08, 2026 at 04:13:33AM +0800, Kuan-Wei Chiu wrote:
> Hi Tom,
> 
> On Wed, Oct 07, 2026 at 01:59:51PM -0600, Tom Rini wrote:
> > On Wed, Oct 07, 2026 at 12:42:03PM -0600, Tom Rini wrote:
> > > On Wed, 23 Sep 2026 21:29:56 +0000, Kuan-Wei Chiu wrote:
> > > 
> > > > Add 9P network filesystem support to U-Boot.
> > > > 
> > > > It allows U-Boot to directly mount host directories in virtualization
> > > > environments via virtio. This is useful for loading kernel and
> > > > initramfs images directly from the host into the VM during development
> > > > and testing without having to rebuild disk images or set up a TFTP
> > > > server.
> > > > 
> > > > [...]
> > > 
> > > Applied to u-boot/main, thanks!
> > > 
> > > [1/6] net: 9p: Add 9P2000.L protocol support
> > >       commit: 48bb83195682d189273bdba813fa67f7f2760d59
> > > [2/6] fs: 9p: Add 9P filesystem support
> > >       commit: 9e14f904f8f12cd9df07e99a679453c8782e523b
> > > [3/6] virtio: 9p: Add 9P transport driver
> > >       commit: 09e668e32b4c14ce5c929d6cebfac75d2aefb90d
> > > [4/6] doc: 9p: Add 9P filesystem documentation
> > >       commit: 7d963df1bc38f5ae070ea8b96e03afc1ef7e23ed
> > > [5/6] test: 9p: Add test for 9P filesystem
> > >       commit: d446ef40b87d53ef7ac59ac9b1d79a16f0a065b0
> > > [6/6] MAINTAINERS: Add entry for 9PFS
> > >       commit: f6002d5e8018714ca80dcf1835c230c99c5090b3
> > 
> > Are there special permissions required for 9p to run? This works in
> > Gitlab, but in Azure:
> > test/py/tests/test_9p.py:46: in test_fs_9p
> >     assert test_file_name in output
> > E   assert '9p_test_small.txt' in "9P Error: No matching 9P transport device found for '-'"
> > 
> That's weird.  In theory, no special permissions should be required.
> That error messag indicates that u-boot didn't detect any 9p transport
> device. I'll take a look at it.
> 
Azure currently points to the github mirror of u-boot-test-hooks,
which does not include my previous u-boot-test-hooks patch that adds
the 9p device to arm64 qemu.

The following change should fix it, although I haven't tested it yet. I
can submit it separately as a formal patch.

Regards,
Kuan-Wei

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 015fc15d5c2..93bdbf4a4cf 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -251,7 +251,7 @@ stages:
           # the below corresponds to .gitlab-ci.yml "before_script"
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
-          git clone --depth=1 https://github.com/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+          git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
           # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
           # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
           ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
