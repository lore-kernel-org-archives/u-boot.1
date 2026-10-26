Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3BF606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I+/THrag;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c46ZIZ+k
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82B0E80DF8;
	Mon, 26 Oct 2026 09:56:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mPNVacQCGKZZ; Mon, 26 Oct 2026 09:56:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BCFCB80E08
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793008578;
	b=astQDQMhsQwPdw9QYyDV3qoL2kOP46TfmAC85K8E9HgPjju2XkNeztGdm5uIuqc5uBi3
	 ELBlaieJqQ8ohCiGt2fwGbUUk07EGIG3tCygNcIfLTGqtkdRmzdb3KgSFXLjD5fVsW1yK
	 /MquEQctVVFJTXhQ8hcerhdLJ3b5SqwKYu3U5YwKcE4NxXkLYVlZiN6XIOB/aFDZw1hZY
	 FV/0CKiS9jeKjcd93xI7qLTpIGQU4QuJ/d7QuXu/kfBHHN3QZ0DLLRfVT6BDEKvfwy5zu
	 IlCU+k2iin1VcwVuoDCnTg5pJRMFov3qk+wF7okPdW0Xm7lNs+IBXDFjvia7LTJxWEg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793008578;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:X-Mailer:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pnBXZ+xzv/8GPe2ukGuhMu9B/KUnc+1/sNmLS4Ry0U8=;
	b=E4emSMcOOuyvg3pjzNfUuJXmF5yTM0qGWPZk5HpmvWV6Q0/hisg5AjqHJivGd+bpfWxb
	 7n1DsiLu/cKbIcrApb8JHF3US1M1VqfMTyfKPF0zqBRql8bYs6YCn3OUj8kQkq7v66gSG
	 +/iSfiT37c+vDUyBYXYkDLlwjlFyq8I/ne8E0TqFQllUTS6PRaK63eqRoLz2v2+bgSS9i
	 x+hc+SgrXnaG+7c3dfY2jjjqyxc4eVb9ExAZlnAfHJ57bHoy2EPBQLjVh4eps3mN41LuW
	 93VBpiLIiWhVBhipmGIMTXCukx5wq21j5OtRUKvST7qP4xQcSTQwgHyvhRGl1vn7TwQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793008578;
	bh=pnBXZ+xzv/8GPe2ukGuhMu9B/KUnc+1/sNmLS4Ry0U8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I+/THraglOLkApsib7FK/97mD3drKEX8pGmVSx7R3zeH8LI9cnpXxU+XsMALE42fL
	 EytDUkMjQL7eD5wiRUWSjWJ02k/FACJkZuNaRc1bUgw68pi4+qHwZ8o/nn4tgwGOVd
	 IgP57YraRpRPVf42WFBxun6QRx/zD6HuRJDaqZp+mp6fkGWVeDH0ZvDn61bhT2SxKH
	 Q4ClNsH6Yx8ObZPvn5X0L4LltY7QeFdSh2N9cqbQyQ4OaUGaQfTrskm4UrY03TB8rE
	 suUxzjHrqTvLr4hUFWx3a/xrrppiEH1MLFLBuZSgN1HinDH8lOw70p/n+MKmQY/Y+G
	 LuL2KeVJxIV8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCFCB80E08;
	Mon, 26 Oct 2026 09:56:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6C893B6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:11:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8FB24004D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:11:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4wupluQmV08 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E969940049
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::829"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793005901;
 b=ILvKavT/btEPjXxdyZ2qXh3iOFViX+nE9tfiV7BIQwyMIwInG4uikQBZKGaJ7nONZ6VB
 d/7XNoPiLIS6wmzjQjlWoGp6mbgwkgvh8UKxTWy7hUNL5jOm+R2gcJvdwO4pgs4Py2JfH
 mjUdcnRiGUI2+z/uVF4rnfTMKEh11JNnKioewvoGPsX1m6W3arF1mDEjqqQDCuwhRY+Eh
 cMl4ZHCB6TdhXZDUHgLXYu2ZyNTe9QCCsTjx+GhHjx7FOB1UIf3kJFaH155n14v7dub4Y
 4EAhG8e8zZU1KR9rRfK0cGOVznPRxJpY3hzR8dgn2whaG3cwVZ8jbMTbgNFsWcUHwLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793005901;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:X-Mailer:
 MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=pnBXZ+xzv/8GPe2ukGuhMu9B/KUnc+1/sNmLS4Ry0U8=;
 b=N9RBMuuDACZZvagrjtWoWm+HcRoq8/3zJRkfNldZeepJT9A7zsENTOjjMR+0GYD+lQDA
 5gTtSMwSyK3mYFkGbBOncm1W7gFarzsU80JT1meKy8xYLgDkeapKzwzg3HuiYKv18YjhP
 WWfBXPgRflqknUJUeHpq79rz040ee6PYcxBDOtQ+dXmh1jnVKpFsMQhomshj5jvVwnGXq
 5ssbFTbKgo/ToRF3GnuQlbOytEzpkHR0c7dyeIVUNsOaWE6v9LvpcaE36yoKwSh6a/ZaH
 5EyFzuJEkVIc7eOibVGKD9fKTfFlZwbntotXZPorEiSo3FPky1lP8K1H45iZKw0hDjg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=c46ZIZ+k; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::829"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com;
 envelope-from=terryzhou05@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=c46ZIZ+k
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E969940049
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:11:40 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-53397554beaso33934701cf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 02:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793005899; cv=none;
 d=google.com; s=arc-20260327;
 b=XuLvmjJDuI3KXa6Isa+LLW1aed5YXcfIZn+TI+eECR9M2VoSrXt71ino4sqwDbVWfZ
 Qr68HOfKLVmBBqX95wsHIZ6f010JBP8LHuGB0lJUBNwNyYv8+qz3dIEvCG4zS6auXKsf
 y1ogEfw5/I2x0a9SzDtOIFuQdjE6hLDCq3dVbnttg5RD0m8pngvkFivs5FtjfwUY48k9
 sm2YJGe1rCgm9AI/5E0kEzy21XXmgaC2kFOIi5LJYgUpha+fTEjfhjE+iWuWmFwC9k2Y
 5Kyg+EpunwffywA8VP3YoebKwxOmERwhTpcAvLRADuhLZaC32E9lY84g7B0ECL6QuhtJ
 Ksuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=pnBXZ+xzv/8GPe2ukGuhMu9B/KUnc+1/sNmLS4Ry0U8=;
 fh=72h8JqrShBQna6xidr+60qowPdwLvr/bAo3nCeKxr5c=;
 b=V7n3nCnMgNbLpIBafCJo80PeyupOglsGFN6ape1xDxS/lTskVXezsIgCTyl/tTC9uS
 ZqpSv9zq6TCS2A+9shj1PHZHxZhwxs6N2gmmlZRiex+wFHQwNHeathZobo+jYNLf/4Ux
 X4AYR6OJh5x+VEF5n2GnovBZfNwMORsJDwxqrFtdM7Yx3dmwrjdmGf6g2T1LPmBkrYWD
 tM0SbkXud9TeaK2x6naXtFTCfdCqO0kckrU6wapKmlmE1h6pVl1COM/xD2ObgELCbQAj
 MV4gC0kx36Cxn36BeOIjk62aWRh1ugokkYnyI2B8TcHsDR037AG/CfyZCbWchTnmj+H+
 fAfg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793005899; x=1793610699;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pnBXZ+xzv/8GPe2ukGuhMu9B/KUnc+1/sNmLS4Ry0U8=;
 b=c46ZIZ+keHeZ+rLfwj4HiDq7i45APm8vMu/gWEE0+FwCVGaRJSOxlu3cBdUDH5pJg7
 zX2N8JvS+bYvHAPtSETgaql3oi2mHKH5f5LMAdl6KMTSSp692+gz4YJgjzh24qzrkR0t
 m5FISDm2ktq07p2sbvNYk8LtiLiSgB+oieDyEJMqZYEDpsELDMDODAGsEP0JOLQkxb/V
 ID7vvxh3zuF38vxE5UnVlIQM85SdjA1McWJ5sv4OQEQ3D1IJFXZug+q3iqQNBWXNXj7a
 9NBnaxsOi/G5me0yMEljZmEdc6f+B4TDo+hvxqg//dg/U1yxX7adceP1qsHqM+HnIx9c
 azPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793005899; x=1793610699;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pnBXZ+xzv/8GPe2ukGuhMu9B/KUnc+1/sNmLS4Ry0U8=;
 b=ZETIjLd0n5siOrBsdfCFNcVzMT071KfDZhvwJpD8b0jwYOz9vIW7mZXXE2/xd9vgD2
 i23u6WTyL0aGt4CAl30R30e1EZadSvx9NeMYpDgOPO0iQyZY0ZGFtnhG1qK3Ay9Jmdhz
 VQgEvsS+hPlIUIU4OmGDmkeERtx6kRHrMEsy0Sff5bdqy32owAtAuLNDl59yCS/lWEsr
 6YsU56E5lh4lyfcZPgnTfYEE0/5P/oX6HUR5/XQbxPJoRWGp+H2ZrS+/ibJoSbdgc4ho
 fyUxQRmoH/JUDj808M39mvpUO9iSeFzLWi2WOjaPKU5yWNvWJLJ8EhzReEoo6egpVrKD
 mcDQ==
X-Gm-Message-State: AFq9FYJiNn1CCAPNFme4TDFlxRAagYTfSWnNBLBiX6FnY4WdFk7yldLm
 AdOCa9Ybm9g9eyqGJMRHrxfgoUAAV8u/nHRbmXDLwM5jt5REWS9/qI3xzcmXrxKqqOymgkiChne
 iCEHugDPqyYMX9E2FpPtMHGnRyBSdrfHDbl7GnJQ=
X-Gm-Gg: AYBFou0J+/QPipxVc31bCv3+YQ5RikQT0NiNqhW9a6HQiwPODvfbJCRduYz7ktMwr0Y
 NBd5zGsdGea6xiweBjkLh6syAZpAr08wBsmIS35MEyAR6HWswdKmDcnCY3EZcaNWIoLtPk+GAly
 Zu/bsZR/HAO8M/1r+5EofoL70xI+petxO9aTcdTtraicpais1BaUZwaY4XQnuBYiw5UpZI7Ao3+
 1+A1dk2coTuMec7TF6KZl3ZBqc9NlYnGuXIsxsNTKvF2FVaoNk5YV3T8EuPGNd7bpOFkJguThbB
 NfSCkyZU9A88SjJhK1dSGC/xRBhqjp94WhLEzTeIMu4gpgM8R0H2uiBBQsLFAzKC3z3mDOvCIJl
 RaYbqFWtdX9st8OiiMpGM1RrTiB6bDr8DtOyh
X-Received: by 2002:a05:622a:5c6:b0:536:7cc1:4b6b with SMTP id
 d75a77b69052e-5383b4a9389mr99302281cf.27.1793005899245; Mon, 26 Oct 2026
 02:11:39 -0700 (PDT)
Received: from 274731240883 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 10:11:37 +0100
Received: from 274731240883 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 10:11:37 +0100
From: "Terry Zhou (Synaptics)" <terryzhou05@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 26 Oct 2026 10:11:37 +0100
X-Gm-Features: AclHuK9SKLGUj12pDzEJDywTl5YCV4v_KTJ08UnDaD6zSvVDmNlwo5F62bL6Sjw
Message-ID: <CAMPWMbrVO9-ZVYQu6Y0GSA37OXzTrg+nyZObyxQJKtJvBErmQw@mail.gmail.com>
Subject: [PATCH] net: preserve the driver error in eth_init()
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, trini@konsulko.com, 
 "Terry Zhou (Synaptics)" <terryzhou05@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 26 Oct 2026 09:56:09 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

eth_init() overwrites the error from eth_start_udev() with eth_errno,
which may still be zero after a successful device probe. This can
report success even when no Ethernet device could be started, causing
DHCP to enter the BOOTP retry loop instead of failing immediately.

Preserve the return value from eth_start_udev() so that callers can
detect the initialization failure.

Signed-off-by: Terry Zhou (Synaptics) <terryzhou05@gmail.com>
---
Validated using downstream SDK U-Boot on Synaptics VS640 and SL2610
Without the fix, driver startup errors are followed by BOOTP retries.
With the fix, DHCP fails without entering the BOOTP retry loop.
DHCP succeeds with the cable connected.

 net/eth-uclass.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 07ec59b97f0..18efbfeda71 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -349,9 +349,7 @@ int eth_init(void)
 			debug("Trying %s\n", current->name);

 			ret = eth_start_udev(current);
-			if (ret < 0)
-				ret = eth_errno;
-			else
+			if (!ret)
 				break;

 			debug("FAIL\n");

base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
-- 
2.34.1
