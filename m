Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949F1CCF2C1
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 11:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36782409BE;
	Sat, 17 Oct 2026 11:55:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UctVDjpWDn3A; Sat, 17 Oct 2026 11:55:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86D0C409BB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792238118;
	b=YJJ9XMvEUW5T7qYL54uiZUhpwjyLrD6IdQlrV1Oea9oNQ5T6LRXSvbVYyXug6I5O6OCb
	 qOlVNXBbFZXiWgZWO2t+/6oUKEFYN+VZ3l4J3ntUKZbielvDrdRCGQluDOWoaRHxfvjky
	 58z2C0jidbU9vePmTFFgrj1DLrTdi1WqquXkUJCJF5cHHN/YpjPhiOcDh1l0HZXnk5b2H
	 HlvT9LnAj5Qx33L4THM8fBrAAnYszzs/2eIBzk2ZAjyBzGgYCof+3N1V6DaiJnd9NZj2Q
	 jSeqzl4PN+LgfsIfPxkl6lcawQ0CZayfIrYXMmOnQqFPExSr9euQ/5TE3mpxXPFhE8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792238118;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nmQdnTMTg33FxdqM0EZT5cST9YQXfEPm3NnkgM3s5Go=;
	b=M9/rqm9nuts4qZ49lDRsGCDCerUvJV1q735TPVoXa9/emU2TaA+r+284mltbzVc4Sg9p
	 IkunFGxj55yFAOOHYAO5BxCQtiEdY6hw3uWGLtSWa5kQ8NAlCVmPMbZeILJNl3K+E62oZ
	 vImWrdciI94Y7jxV3y3FV0xEG4hucZ3S2Yxu+FNyVhbYgQz5di+SvfrazzPgSNCjqk5Ni
	 ymuGjB5wWM8Oh6aCQoaFhwKiJVaq/vmK6isq6DbjRc6n46EHWuwb+ajZh5f+yP9mKS34q
	 QIfVb/O4ar5iwxpOSAerTpGmTXevIcStjSEJWCl0a6hyGrM4EDGWVospWupJleF/fAg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792238118;
	bh=nmQdnTMTg33FxdqM0EZT5cST9YQXfEPm3NnkgM3s5Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wpFoDqvCWMcrLjPW/RnfXWWpVKu+RJF9x7ymanKQOHpJlXiA1Zul9kvm1e6Pk2H23
	 z+lP6elWw6HuIEsZ1E4K88ZOgPNdSdWb3eLTr2Yf4VKuHideLYmQC5MYNOWLOiMYxw
	 NU23UTmWWmWq8Uxhpgb6oyZYEUJFeiS9ngwARXRrYPhNHNboYiJzioSmZE2kDoHRoF
	 VUyoKCcJ0QKIv+qmZo0bkWxiSdgGf/EeQOsjmFrM2noRyy8DNbPm5+g9cGc+S++n3f
	 UYdR72XY7GmKN32Si7pB136BNC/cmt86O2YfTRuERQ8cdqQbxaAMFzRtnq9XYv/fq0
	 Ra9ty/campj4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86D0C409BB;
	Sat, 17 Oct 2026 11:55:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C0B475
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 323B0606E3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vkuTWYtYS7HB for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 11:55:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DF946069E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792238116;
 b=MW3TENoEhyecRM+cg0gaRztufYiphleGetmZ3O9dn7C3m6js7hIpbAiys8rw8yiTQaBh
 a3wQczFnv0mlz++xX57wE39ACWTfhcrHn5zqKEODVv9kU5ZNmnvgpiK5o0MyC5GqOHsJF
 IkbyR8axiPIwU30sipXqUFTiEEDflClXp12MHj5//fHDIYJUfcvyXWSYyQh5gTFE9Pqh3
 jEytEwUFV4DPDtPbsuhsdIJEje8u1VY9nBj4c81SrpnB8jvNFB0pNE1XQ77wZIgyj4qcK
 pTzdZsEuASDzG62AGnHPLo0ue4o3TzBVWsTdyy/h8HyHn+tGOMSt00xEQtTmzo0q4YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792238116;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=nmQdnTMTg33FxdqM0EZT5cST9YQXfEPm3NnkgM3s5Go=;
 b=gbuVpmSngS/0zv7D7Yo4GN+bZRqqOoDzEC9YFooGIlffWJ2MWxrhyVQgUivdlaX/a/K+
 xiXmAyVUQsBuOrN+RHqjW5aIB4Em59Yq6i/qXBkNmQPc/lr3IsoRklXUdqDoQwK7ol7S8
 nyOXwdtdb5TZ+I4WkJSCWeSq5XVDO8zf0buakj+cYX0lRt93C3cummBpzfw2BVO+RNnK+
 B/vrs4t1bqgnSDXrajAScumLPELBgIw3vKuU2Cnh6JS4qBoLaDZRMkdJe06JDA1YaGmMF
 nD3PHOv+71o0LSUmYZ8nSRvvd5A3/IOG1LG5haRHWZ48wJf5LsRSJOj27xkShMy5zew==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fN5HJNGi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fN5HJNGi
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2DF946069E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:55:15 +0000 (UTC)
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-30b6dad2382so2055323eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 04:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792238114; x=1792842914;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nmQdnTMTg33FxdqM0EZT5cST9YQXfEPm3NnkgM3s5Go=;
 b=fN5HJNGioKcLPHK9kkpZsBisT792ip2nvkA0NjGh2EeNGqy+IcPFkHXZ6qJtb4R1AX
 HnBvOcYurhvvVYj5UGEr5couyxsXHuAfE2LsCfHnuJrcvKmJBKDT7Gy0Y/tKFJvYc+Ys
 hTkesIxoj7X1k9Uf2JwWRbvZ7W9ME7VMwMn6zn1uG8KnbOAEOWzblCTddUwerULCn3Jz
 MdWiBUipZoGwl8dt3SeVXfU7DaeRo7O5HCCfk8uQeKZK+L0fno7K/6mmqFDXF58Xm/+8
 wHcf2FOBK1H2O1jHKOjAPqpWrOgJGSKRs8XOmzHQJWt2RllbqK7MqHS7wTr2JeoQKyFS
 /zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792238114; x=1792842914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nmQdnTMTg33FxdqM0EZT5cST9YQXfEPm3NnkgM3s5Go=;
 b=Iwnru6cgK1FyzoD+Ez+aOujWjZAXrvAzW2lEc9T9QRE8J7xQ50pdEKAf1A3Es4xMds
 IGVIEyMmI8hrpLkJrpPHR4kkybP63EwTbOTEFyQIwbeiZNDw/1WTwt6MaOKO+BMld96l
 Fwnk3wj2DC3h9mMLkz24pwu/F/5KiTZi9I+6mpKKXpXjmdY4w43wvpCmkroHIsXT/yl0
 bO3HSoLjkbTvM2NQ3rN916jaYYke9tH9tNjdbaihgpYM24PoGwwyLQ78B2U9uFVKafv/
 TyTFwqHK++LrMT02+4DsFFgu4j9+QKDg+xMH2g2ozKsJkj106ob+JDP3+R/6REVMl9+U
 pnXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6tyA//63KC0jPlRblEFHyRYkEPbHvTXQtklU/JTWELP3XFLWW/+K2R8Y9hL81U3a8d/MgKc4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIvI3O3KWzoUDIzEiDiw2+6mFKy8f605aBPtB36/31vitFSYigU
 S7wkrZIqm0Ho8l7LaMti5iIHpY91xm9dHuCKJ2Asy48KJy4T181KDJ/Fx+HRrEbt
X-Gm-Gg: AYBFou0onWPvGGThHnszOF+N3o0AgtxpNfx55uW3vh9cxHCULTliXfTsTQy34aCJ38z
 8n798yb/T+aBISRjl0+KHYw+ZRZ4Op/yXgfaLJH2H6GnjHFPxVvf2IWmoYO/J/xTVXPgFM4S3X0
 VDpd8KTKG4rQQUemjkP7FxCINKyaBUkCvZRsCSbHQSB+tXMrn0kxiQyTxP2l4//4T/RL+rU1MmW
 ld6ujODBVN3BjmgQL0KtIjdL/8ddG1qCMx7/p4yF6w75EZAlNgJO5nErr4pXGBSi829eo5u0TM1
 RSu3+WfE++p6H1AULMK8iRhW8wzS+k1WNjWXpZh+VU6PQbw+dzUoe+2PjSa8HTn1CWDcZUXRZQX
 ytPP8Qm8JSUak3lGZblsKAJcGo89SqamFUykj9lePVilQWb4aj4+MwfbiteQi74NeKeE6F4QXP2
 K+R8JApxYqzPHNz/XbvcGytKTPGN5X5o85JwPb80gz4auZf8FSjFt+HgaT9UoxAJb/Thx9mVc0S
 x7tbdn8fONoh3+O5SMPAfw8thtq5wc7CuosJuK8TTmqh8Ebvwx5XTkku2kGYt+rO9IZYHKtl6G1
 lrGi75UOShtwHnKUtLEhaOSDzSD2MASpHW+DdSyyPO7kCcvzhJf4lA==
X-Received: by 2002:a05:7301:424a:b0:35b:9bd:1435 with SMTP id
 5a478bee46e88-3619ea236e5mr3162626eec.2.1792238113961; 
 Sat, 17 Oct 2026 04:55:13 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081fa5a6esm15490992eec.16.2026.10.17.04.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 04:55:13 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 3/3] board: qemu: arm/riscv: Probe watchdogs late
Date: Sat, 17 Oct 2026 19:55:10 +0800
Message-ID: <20261017115510.2756292-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69463bbb6e376894444103b6eaf478f854ac4c6f.1792074141.git.jan.kiszka@siemens.com>
References: <cover.1792074141.git.jan.kiszka@siemens.com>
 <69463bbb6e376894444103b6eaf478f854ac4c6f.1792074141.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Jan,

On Thu, Oct 15, 2026 at 04:22:21PM +0200, Jan Kiszka wrote:
> The only watchdog QEMU offers us on non-x86 virt platforms is the
> i6300esb. This one is PCI-attached, but watchdog probing will happen
> before PCI, so will miss it. Redo this late so that we gain autostart
> support.

I tested the whole series on qemu-riscv64_smode_defconfig with WDT,
WATCHDOG and WDT_I6300ESB enabled and WATCHDOG_TIMEOUT_MSECS=5000, on
QEMU 11.1.2 with "-M virt -device i6300esb":

- the watchdog autostarts ("WDT:   Started i6300esb_wdt with servicing
  every 1000ms (5s timeout)") and the machine stays up while idle at
  the prompt
- "go" to an endless loop resets the machine after about 5 s
- "wdt stop" followed by the same loop: no reset
- without "-device i6300esb": no WDT output and no change in behaviour
- with only 1/3 and 2/3 applied, the device shows up in "wdt list" but
  is never started, so this patch is what makes autostart work

I did not test qemu-arm.

Reviewed-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode

Thanks,
Hung-Chun
