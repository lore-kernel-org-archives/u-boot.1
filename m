Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A127CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:03:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44B6560D67;
	Thu,  1 Oct 2026 16:03:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9aUrWC-N4xQU; Thu,  1 Oct 2026 16:03:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 75BA060D76
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870584;
	b=kn6+MFemuS+Fb9WjwE1sD5B7TH54Z9NAsLi5XZTptf4f28OMx8B7R4RSN55AKdV+JVi9
	 0dMHwif+FHMFwaJHVXXxGhimZDrfGF7IFXMeqEDPhCdgGr0JHEt6CwgV7aYItSv/1zj64
	 6OFRrczti1byktmOI8FWJIlCFiQkcOlP3gibEK48O1ixFVndFUeObkIay/KBpqWthapJb
	 atE262/8oVISYnNwUx4cDaH0HWioYA2PAIwOrtsNWFGx/e9I8A1Vblx7UBd3WOsWUJLBo
	 3YIqkDhxUBwsgpmyM/gUbpypJRVfqN3ipilGUlDL+tCKl/FKQvrpUBJc6V5YoAKsAgA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+kLqY3+JdP8C01ojIj79TOB5uQvZExi8ytE1q/bmTSE=;
	b=EINBam8gjhy7CoSgD0pc6QriNLNff/7PeUNbSxxPNXgaOPWuHEpFY4JEevWY1J7UKVos
	 EXFJt5zv17HTaJtZDgOk9GuV/koq8GRtvJeIi0jc00T1OfRByHz6bJxGkm5jqPi2S4Rsy
	 ZoIMJQuQqKUNxr9LqTcIvc7RIoiNguwAEJ89WCe5PXdMimsFfc6qwyTLo7E2PxMi2edJb
	 mzhxwZQGN95XGL1wZqZdprsajnfZCTG+qAtglv6DpoeD3SpHHvlnOIO+UPHQNV0BtwzF2
	 IQtimqIQHhaekhtxisN1YwwI3CNxELC63JLBvXNNJPdITsA3dmBysaHnU4RH4IgC0Jg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870584;
	bh=+kLqY3+JdP8C01ojIj79TOB5uQvZExi8ytE1q/bmTSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GJiytX47e52NGXnBRUzNy1fO8wSYeBbT+9bfnQGNRzre4XtD2DmNbzn0DmosxOkxn
	 qOhMf0HxPv82S4nA5SbEkOVUYM9JVRfCQgjj00pcA47w6RQk3BWNcj5/pbMVv8X/Xw
	 Gd6O43LV8o3RHePUmb24dbARvHbw4Oiu+2Guw8u+lz4i+cVHWek3OwmXmhx21CSnQk
	 LBLs9aUrAUeGheBQHvxtxd6uVHmbwWAsVJHWKQaMKbnAnDyDRAmBCWgvmHasZnx3aB
	 wYNcJmXZLBOuUN6BJzRPbOgmHdViW1WfXNML9jVbi4rQxP1HmwsKt43lYGQHrqVGQF
	 kOg/bnnet51ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75BA060D76;
	Thu,  1 Oct 2026 16:03:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1892432F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A1764052A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xefvZw7iMsa7 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:03:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 11ABB40528
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::27"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870582;
 b=Ib7Q9trm/zF4VwxOKDpNMGmQXBfuG9IKztT7niOa/CGGndTkyAVNDLSUUYZ56/BAx5Yz
 zGO9EIbmG916X97gZya5UKo1GBc3xDYTPKnraWgIP1RYNdWypFrEAqNhUha9ONo8MsY4f
 baj5CZByb0o54VG41/Gcwpy1BWaNtky0SFXfqDGPQFaqj3cL9J6CusY4h0MNwtNDb0uEJ
 RRwHnzd8AcoI4diEwXlXO+8sKUXvXcx6s5S42iIi0PyT5Vp4vsXfBAxcJbK39B6zE5JUW
 VlinuPkcuiidfYyV2NhVwqYRGgxrQNQC4mEy7AM8RQqv3uMkC2wxdW73mBRKbyNnVAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870582;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=+kLqY3+JdP8C01ojIj79TOB5uQvZExi8ytE1q/bmTSE=;
 b=K/ETuIVh5QOYsm/UnUSBC6vQLxr9LEA6lrFHxIIfw5vJlyC7PhbDBdZUQlnInxaYYyYO
 61SJ1FcC4eyucZwU5gT5cffVmGi86bexNqaE5FTI2SatOMDWQaOiUZu9hvF5mL7Noog63
 oYsZOQRe/R2pc7AnFF6h1QYsWuVsC12zbiF2SqYdxbDFBPNz+0h81XSw6fA5Z7dKNtFxX
 jmIST+39HJTT77Hx6aFR35gIAl/sUN9T4UpjYjQWrjCrKFd167fVrKLp/I/iE7T/DuPbw
 RRk0vhShghgQ2uh3BpxwEUtkEVYXQnPjE8DXCyc5vZliIFD2LYSmSRkJ2iX8plqVOAg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mayicGim; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::27"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::27; helo=mail-ed2-x27.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mayicGim
Received: from mail-ed2-x27.google.com (mail-ed2-x27.google.com
 [IPv6:2a00:1450:4864:33::27])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11ABB40528
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:03:01 +0000 (UTC)
Received: by mail-ed2-x27.google.com with SMTP id
 4fb4d7f45d1cf-6aa135d6e97so10627217a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870579; cv=none;
 d=google.com; s=arc-20260327;
 b=ixxHll/h9eppKZRRCyoK9RSzOx8BC7crnWP6F+ummU1TyuGk9kJSeSp2Ag3N0LmWse
 olkze8l5d/AsScWKtC340vdcvnoqZKs/kf0lUpMbGmnvtjmwGteYO+0rFCbaVqIK6s7h
 7+Ag3uqCE2ilDag9eIBohtYKMmXBZgtaYb5KWFFM0jnZ37K5JA0ol1zRHkmpmOWgiySr
 VWr4+g5BHjC5UQpIj/ccX5Iha2DOiHpBmMmveO+uO6nbfyKEtq4Oly9DS3CFEqANRSbR
 2PtU5vD+KMi6OJRwdDK1/aiLLtFGnsYFBU7fuOatgIDSOHTf6ogWOreI+G7/Fng86Rm+
 SwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+kLqY3+JdP8C01ojIj79TOB5uQvZExi8ytE1q/bmTSE=;
 fh=KE6zfrJoJOrCbkKcT1086fg4XyXkSQI5ZrofqXROovU=;
 b=bgbFVZMSpQYO0OoO8GMf00q2inAEjsnfTtAjlnFSeOu4V7NkEpnhSBU2L5rb/ML6xS
 eyNED4tbSwf2DN8jJuJBUlrroXYCO/AEPGGBu+p80aP+nZbD9sRw1PoCgHTZh/CpCuD4
 /cgJSI7smjcCroYJK8Jo2tHtFacxJjal9NMsn6q2gEhRF7DECN9MZTp7PSLmIWj560oN
 DvivCeKrXcpTWbuFADxOg1CpNvbf3aRNCB+qie8bO800G5Jrm3/8z8d0xAfMoQKz203O
 Tvj2HPFjnYTaOu7R5bIiXF6Zn0zBs2+vath9HD602h2LZd4L2c8u/nDNaxuZc/7ZCecB
 CgUw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870579; x=1791475379;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+kLqY3+JdP8C01ojIj79TOB5uQvZExi8ytE1q/bmTSE=;
 b=mayicGimodRKSJ7tihQreRoVcMKJ9OCX5MHX5+ZXWiTZlnQ+jeMdGuETf+6rDzqFOA
 k4FszLmQycLgNJd8XDyTLrDs+CMsvMPW3Ffe5/I6oio0BZMikt12oR3V15GXjOpeLekJ
 M1kmLjPnMUiQZ1dTkWWRT9xcsnG2HYBi2ntSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870579; x=1791475379;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+kLqY3+JdP8C01ojIj79TOB5uQvZExi8ytE1q/bmTSE=;
 b=npdFB+NLSjNVNRKIuMp7Yu/QjYsfxx3fOHS5+kLn7Ql4pkzIB1bD0Z2tYd6utPYz9q
 nSTYDoEf0OLb/vtur3sWEeSGMsvaEac3ewh6T/Sy4x36PbFJ6wfMVKIim3ay2YGiv7lc
 RZh6LIkoHubA7t9mgNr8gMjjInd7jYFcsRT8wPzIQELyz8YtMaI0KH62xf9j+mrnNs4y
 fKB77XIDkh6Om+R+4jpuNjJk9cePDMxTEPXtYaoZBtM9o9HGkt6HKbCG8+Ah1TbiccQR
 q169OzZRs6ZSjHSWPYocR6DGniTWCThDWSQ0s8LY5mmiKjxrT56Xzn6jAzxRiRg1i/7/
 J6ow==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpFBUl23OYi7lCcWXiFQ7vMsS2u3dhsr3aBsPBDnwpLcZb5Edt+pc8Mch3P+ZXAIGZDj3JczA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lF11JHrpgS9eJfdHYNUCfDr/XZq9bUMeRfOJoumUps+RVjbjiW
 mBXOQvvYC1uor5UJRdYskeISbGxYiGWxFNPaqsbpTX8brKImmq6R0egKGDGq8UJjlXMn0I/wV7s
 hprXsdlTWvC+YjWNKd7OMtqqSHA9IDCVN1XdcMgh3
X-Gm-Gg: AYBFou3o5GvkrOeCO3c2VTBpc9zR40zuFyprkF2y1ewuxp1nDZ/0iWuvehmn2eugToK
 yH7Q6rMZ/BKHJvC5GTdvA9DMaXeyE9ec2m+nnwUDireljWPW9PlvLWPtDLqEK3CQr1e9AAw2ctS
 kTXP33jES0ct0Hq4eG4HxyLYQjnhlzQfyTSVuicgYocPi8Q95V7P52Z2bAILZUm+ndC2w34he2s
 TQLBBnJ/IzpboOzyrp5fva4eUcX0YZwZbAOs6LaW+/i5Mfrms+2hxU+TAbRRtAogNwImWja2sAP
 DVm9tMRMlFoa6EgaASAxDI7LHuMjOaGE0+rIWRLtKpL9C8gfOJ0XPW3Y
X-Received: by 2002:a17:907:724e:b0:c2e:969:a4b0 with SMTP id
 a640c23a62f3a-c2e4af53d29mr2382566b.38.1790870579577; Thu, 01 Oct 2026
 09:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
 <09c5c1f0cb1b49d571529f8c04191b8a24eb5505.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <09c5c1f0cb1b49d571529f8c04191b8a24eb5505.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:02:45 +0100
X-Gm-Features: AclHuK-6PyCOlQ4thpLSGyGbAmPd8rklXy5WXOLfnCa53yoAHJB1h_xTqtowncg
Message-ID: <CAFLszTjjW1rgUcAc=tZf2y22VEFfjsh4fMZJKYr2gP=LPgTnxQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] boot: bootm: release the imagemap on every failing
 exit
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
> boot: bootm: release the imagemap on every failing exit
>
> Three error paths in bootm_run_states() return directly instead of
> reaching the err label, so the imagemap device and the LMB reservations
> its translation table holds survive a failed bootm: the missing OS boot
> function, an unsupported subcommand, and any error carried out of the
> earlier states. The first of those also left interrupts disabled.
>
> Route all three through err, which already releases the imagemap and
> re-enables interrupts.
>
> Fixes: 46d32e38ee4e ("boot: fit: support on-demand loading in fit_image_load()")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> boot/bootm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

> The first of those also left interrupts disabled.

Just to check: iflag is set as soon as BOOTM_STATE_LOADOS runs, so a
later ramdisk/FDT failure or a failed subcommand also returned with
interrupts disabled. All three paths had this problem, not just the
first.

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -1265,18 +1265,17 @@ int bootm_run_states(struct bootm_info *bmi, int states)
>       /* From now on, we need the OS boot function */
>       if (ret)
> -             return ret;
> +             goto err;

The err label does more than release resources. It also handles
BOOTM_ERR_RESET / BOOTM_ERR_UNIMPLEMENTED, which was only meant for
errors from bootm_load_os(). BOOTM_ERR_RESET is -1, and
boot_ramdisk_high() returns -1 on any failure, so with this patch a
'ramdisk - allocation error' or 'in-place initrd alloc failed' now
prints 'Resetting the board...' and calls reset_cpu() instead of
returning the error. The same applies to the subcommand path below: on
ARM, do_bootm_linux() returns -1 for BOOTM_STATE_OS_BD_T and
BOOTM_STATE_OS_CMDLINE, so 'bootm bdt' would reset the board. This
happens whether or not an imagemap is in use.

Please can you keep the reset/unimplemented handling for the load_os
path only? One way is to give that path its own label that falls
through to the common cleanup. Another is to move the imagemap release
and enable_interrupts() into a separate label after the BOOTM_ERR_*
checks, and send these three exits there. What do you think?

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -1318,7 +1317,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
>       if (ret) {
>               printf("subcommand failed (err=%d)\n", ret);
> -             return ret;
> +             goto err;
>       }

See above. It would also be worth adding a sandbox test for a failing
bootm subcommand with an imagemap attached, so this path is covered.

Regards,
Simon
