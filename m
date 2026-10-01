Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB27CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C29C760D64;
	Thu,  1 Oct 2026 16:00:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nqib4WsNPBDh; Thu,  1 Oct 2026 16:00:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EF05260B74
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870441;
	b=cSHmdJiYRqub3U3N6SF2Qn4wtRBuGe78D+02SGmgsEIyysWEWV4OPtvRPeTa/4G0xUmJ
	 YPBijRnHFhG2Ekis3cRm6HP+wkdm79VqVXMQPykZAK+cUfjf7PzLlpgmm7qO7Ogzam5fL
	 JfRoyHYMlQa73kpDKWcVW1KZdVRbxq9A+5w70KIGBKAiWZd7kwD6JIse81+fcq6cZc8wB
	 3OpjQnRAGuUMrj71Yz0ZBL6jgCP1VEXyqTTcaNf6sCONFuZKbRBlhruA0E3T5dzeObXvG
	 LsL6q9je+T1ptAhSwXvf+pbuAavWKaJXY3/tpiePBIbXgL7/sjbyZfhDe5soZTe/v0Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=m96j3CYx1xmic3BL4Z8BGQScyEw88aPFjmMhja/m2ZY=;
	b=k0Cvmu02x/v+pHX8XKMcx4Vk1rTU6xir4cEBIwicqTRzN5ttM0ndvcsorBDNwVPvSKzI
	 wz/Rs8yAMdxXBbYMUASTqaHiODOu45tv2YcGkR3SlhNoqnEdDNVtHE2yteX/R4pYTe/5h
	 OQpW+/RpcXWe+sDhXQuzDguzAFPSNcV7ZR6lYPmsCm82CWegg9xedPpZSBLJUfmJ4y/tE
	 VOfU7bfG4IYN47pHYzn1sc1LqGzPWVyTicBJmXpvazqYYysDydPt2RQqtqt8teflMI5Fj
	 mOeYb0uGSMtePVkeL2iSGA42ke+cRfDIix7C0WmZPQPUo/dksL1Ibos5FY6phbsvsYA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J9fGa2OO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870441;
	bh=m96j3CYx1xmic3BL4Z8BGQScyEw88aPFjmMhja/m2ZY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lhYxM8MKtbu4AFgIIkY3p6I9VU0Dw/6OG2V9lR6ZZJeVULkqrbz6FOYBXt+u47r8H
	 wanlM28VZXgWvlsFPLy6oDVdvGKkijqiw7TtcF58NQCNbLhIM+XnC4nrb64q1KFJtS
	 1p5VJKVvgt/Yt4CEVABOBVusouH+TK8CWGHvOdu2ZoQhf3GwaWamPyAZ/Mpnl30T1K
	 kJxFRJJSjn2W8jjgz6gskibT1V20FoFEIsMp/uuw3tQqAWKUud+86gQL9r3owdei4S
	 Ra3MPenpz0N8gALcYnXlwFNCOj1DTb2Ve6XJB5RE66MfLI/6HLDhioMuVkt85fWddV
	 FuU46WUE3tiiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF05260B74;
	Thu,  1 Oct 2026 16:00:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC02733B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1A6C60B74
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0RD3ZD5omxtP for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:00:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DBDB260B18
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:3b::29"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870439;
 b=S62owUcsxy4SWC9rUqYM8K5/Fbsbnqujwk2rXGcP5A4wFiU7nMmU7AVkenIQROrG5XEG
 Q1ofr8eTw1o4biYmW74gSZn38wCGWbE3W5J9c9AQF2BhqT4OSOI27bwYMGtUd4Z749Km+
 61u0GhfxfT7cBKJ19xnXGdiHsN4mR3uUDsxEUt+qy7fstmWsABX4HbUBboW9PIHCQ04gf
 TlNyaTAZ3rs9PVYS0PlOAH57WZcmKrUV0rwHV+El9W2q3NBnwSQZUaKk9ErZ6+Dc0x4S4
 +ptZydEnq3GbCMwStDu/JbXVuF9U3Jfr1fKiikeQK90oPS50QYlXDXM0NvOfVda3dig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870439;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=m96j3CYx1xmic3BL4Z8BGQScyEw88aPFjmMhja/m2ZY=;
 b=tAjeM+lR5jFWzicpxAKLOGLUAp52au0Cx3t04FcP9KZOuCm2rqqUH6OQm2TY5dM5xhqD
 3rjG+7tIObkZsd/71twPFDDzFcC0woba8hmnr7sHaMeCdOJGp+xEna5j1EX2X1L7+NpYo
 muD5CL65qX5h429/XZfUKYfzToESa+qmXYwUD5dZmLDMb61LGJ1re9coYh4uycBJw8nSr
 CvCj+P7b8icaPTm7ZOqDGWkj5YT1nIMvyHo3Ry6yWjB2TJlM7kaciE+XIbYcf3HCjGRxc
 U+/drdmMRcoU0/NF7z2L68Pzrd1WckquKuIdQ2wmqo0mqpogOZ/p2ASwDEiGRqTTNSQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=J9fGa2OO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:3b::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::29; helo=mail-pz2-x29.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=J9fGa2OO
Received: from mail-pz2-x29.google.com (mail-pz2-x29.google.com
 [IPv6:2607:f8b0:4864:3b::29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBDB260B18
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:38 +0000 (UTC)
Received: by mail-pz2-x29.google.com with SMTP id
 d2e1a72fcca58-88732460a36so1304936b3a.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870438; cv=none;
 d=google.com; s=arc-20260327;
 b=Q8z5oSk8jLe0Mzz/K5rKeIujlfLgk/MgCudnqfLUYH3AGsCdaqKh1Q91GXnQdM6x7x
 zwUBL9zJe5QM7n9tROnvE3dx05+uHDXvi+t3H9zJ5dK+TKJM7/qofwJRomToT20dlSvt
 +FWoNTLR6YliJysjxeOtN7Q+slBzrzIHshrpu+Kxnqy5J31p9h4pLy3gUyvGKbcPjuOW
 2nbiSyD6QhMTtdQsVQO3awr6la0Wemkv+Jo+j6ibqcSDqWe4JZbg8TmFBIGYoi1Uv5TJ
 SSX27dvnTb4Gjdx1DaOc+uViHIdHIN8mm5cgToYMxkBhP4AE0Lncz8YH63Y4x9qN03eV
 tHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m96j3CYx1xmic3BL4Z8BGQScyEw88aPFjmMhja/m2ZY=;
 fh=1RVHjn0Zk1rMG+C017PuisFbdTsEouWZ3XqWINBBat4=;
 b=I19txBb1quTTOobrvoazK1+4R2yo6OA8Dm48cPPxfaumUay+cfXqpD4wYgKuDFPBZh
 4TgKEi5NVEd+yULd6dnvjfZcsiUpktVQ4CBdhSiFj2QT68FFWkTCd6N1oDInWdZXYpjJ
 /MmA4itNfJdiVYQjTLdrIIxvODc/TmgeLCj02EeJ1tb4G5qob9C9zvbWXc9gNKy+55Ag
 5OgB3OU1o0MZQULHmmKiqYAiNrClsUsR624eK6jfSwrxxougMlycpxRJzmP15zEOHaLi
 prLJd3YPX7ckBqvvCyOuREA6X5f6ZFD4bZuB0bLPh6wG8+29EnLuy4FQTAbYZAAzLRPi
 9ecA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870438; x=1791475238;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m96j3CYx1xmic3BL4Z8BGQScyEw88aPFjmMhja/m2ZY=;
 b=J9fGa2OONa732L1gorWrgbKt+7TadRSc1ymGmTFJftLIC/4WhbqNsXTBQ1ptGBcHNG
 aAy+AvpdqtdpsSgvZ/OrJhdzVzRZeZF6oZHn7AqGWDu1USg4srz61x42zkPK9F2ONMZI
 cDMo34naDo78leGIHEyQ5hF0L+9iGVsNe0+Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870438; x=1791475238;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m96j3CYx1xmic3BL4Z8BGQScyEw88aPFjmMhja/m2ZY=;
 b=Qpur0fNHxMFPZtiucEO4hZpZUCYNwu/hjvHLRezB8MM1sYGa7nTjbL+UjpZubZNue4
 9sLETS3RbI5qtLIsOlacYQAXzYKXbZ1c+pUgFzL6MBUuz4WAOf+b0c+8P/s0LPkqAPtc
 QZZqmsSzZFSFDizGThLBMgvSleKyuMrRPkElgPTn39YDEyJNjT4BargOKEmsAInxsN40
 U0mG/AOBHBG9pk5z59rcdU3tTTiq3FNkCTuc8YuxdCS3bGonMhvHnZhjisGh0phsEb1T
 RWYKo7e4ZOdP0zj/HygIg0nrQqgFQnacyi5QeMpIzowTLob+qSMsdDI4HdJRlOPlaDuV
 96Eg==
X-Forwarded-Encrypted: i=1;
 AKwUvByVklTXYoDV4jCDIHdNNCEjDCrgmfRS7+thrMrtNoioRh3mAkmxqxjdSPIF0D6e5I0PqFVnDrg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mfpGF/JPbIlSaCtirfov6rKiPWZn7oZ0abstcfgkrIBQ+KORjc
 xj4xUj25AQN0xQksRNjSWGx19FeXn4a3pKMdXqmsQzaXoNYrpoHoLUXV2IQ4NcyN/n+XIqbJiHq
 HqcvNJZ0mjEgE9u4o4/C19MnfJ3ESMufwocyH8pDC
X-Gm-Gg: AYBFou34bLqxYO5eriO/BjSDa2CgXOY5JA9KVRbtVnr4bXMWZNatQzf+WGwikwU0aT0
 jb1Qfk4jPwD2tTAGbtA8VhZ3gPWTdiwqFOH7dSnZCMFiyP6wcEChShfNTgYryFuSFGRJjCEpXqH
 M1PLtMGYpXUT61WGlyvG8FhEqcl2OOmDkeTW/6+k/e1TAs5760sU8omUy7cqw1KcGeV9rS3KKA9
 BhsPc84L2Ef/WO11AP5HWO9E+qgcAZmV5eWOA3q+mIBhT5dxGtUIqMhuKO8iudSYdUjoMZLwIw/
 eNYGHXt8n55v8IlJ0tptho066YW0G/itIgcFs9n3p8P/Nkp7NPDt8wZ/
X-Received: by 2002:a05:6a00:2d19:b0:888:402c:b8ea with SMTP id
 d2e1a72fcca58-88af846f8bdmr6507b3a.41.1790870437441; Thu, 01 Oct 2026
 09:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
 <57d688c070e2624e8d37a4e16a0f0d3ac3806410.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <57d688c070e2624e8d37a4e16a0f0d3ac3806410.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 16:59:49 +0100
X-Gm-Features: AclHuK_go1MQ9ZhQFVHD8vJQXOEVuldcsePIB8bH_Zo-Wc71jnJyzY-9HtBkVX0
Message-ID: <CAFLszTjEwMCXqxJ64oJomm6BVT3p-NUrj4e+rknc6NzoX3HpNA@mail.gmail.com>
Subject: Re: [PATCH 03/11] cmd: ubi: unbind the block device when detaching UBI
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.u-boot-project.org, 
 openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Daniel,

On 2026-09-29T00:04:16, Daniel Golle <daniel@makrotopia.org> wrote:
> cmd: ubi: unbind the block device when detaching UBI
>
> The ubi_blk device is parented to the MTD device UBI was attached to,
> but ubi_detach() leaves it bound. After 'ubi part A; ubi detach; ubi
> part B' the device still hangs off A's MTD while UBI sits on B, so the
> driver-model tree describes a parent that is no longer in use and A's
> MTD can no longer be removed. Reads happen to keep working only because
> get_ubi_device() always returns ubi_devices[0].
>
> Return the new device from ubi_bind(), remember it, and unbind it in
> ubi_detach() so the next attach binds a fresh one under the right
> parent. Tracking the device also replaces the scan of every UCLASS_BLK
> device that was used to find it.
>
> Fixes: dec405d1653a ("cmd: ubi: create a ubi_blk device when attaching UBI")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> cmd/ubi.c               | 73 +++++++++++++++++++++++++++++--------------------
>  drivers/mtd/ubi/block.c |  4 ++-
>  include/ubi_uboot.h     |  4 +--
>  3 files changed, 49 insertions(+), 32 deletions(-)

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -650,6 +651,47 @@ static int ubi_set_skip_check(const char *volume, bool skip_check)
> +#if CONFIG_IS_ENABLED(UBI_BLOCK)
> +static struct udevice *ubi_blk_dev;
> +
> +static void ubi_blk_bind_once(void)
> +{
> +     struct udevice *parent;
> +     int ret;
> +
> +     /*
> +      * A single ubi_blk device serves all volumes of the attached UBI
> +      * device, the volume being selected through the block descriptor's
> +      * hwpart. It is parented to the MTD device UBI sits on, so it must
> +      * not outlive the attach that created it.
> +      */
> +     if (ubi_blk_dev)
> +             return;

Driver model can free this device without cmd/ubi.c knowing. If
anything unbinds the MTD parent (e.g. 'unbind' on the flash device),
DM unbinds the ubi_blk child too, leaving ubi_blk_dev pointing at
freed memory. The next ubi_detach() passes it to device_remove(), and
the next ubi_part() returns early and never binds a new device.

Patch 11 makes this easier to hit. With UTF_DM the DM tree is torn
down after each test, so if imagemap_test_ubiblock() fails an
assertion between ubi_part() and the final ubi_detach(), the next
run's initial ubi_detach() uses the stale pointer. The UCLASS_BLK scan
you are removing does not have this problem, since it can only find
devices that still exist.

Please can you keep the scan, and use it in ubi_blk_unbind() too to
find the device to unbind? That still fixes the wrong-parent problem
without global state. What do you think?

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -650,6 +651,47 @@ static int ubi_set_skip_check(const char *volume, bool skip_check)
> +     device_remove(ubi_blk_dev, DM_REMOVE_NORMAL);
> +     device_unbind(ubi_blk_dev);
> +     ubi_blk_dev = NULL;

Both return values are ignored. If device_remove() fails,
device_unbind() returns -EINVAL for an activated device, and the
pointer is cleared anyway, so the device stays bound under the old
parent, which is the case this patch is trying to fix. Please at least
log the error.

Regards,
Simon
