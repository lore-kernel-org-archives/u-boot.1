Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A1606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZUTAMTsd;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GHLOE0uu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1D5A607B9;
	Fri, 23 Oct 2026 04:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BK8FN2EYwPvD; Fri, 23 Oct 2026 04:59:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F32D260664
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731560;
	b=U2B1cotjeayrmixRdtq+P0iQYGhvN0zkIeGrXCQ0w0EPohLKVVWGx4ceX3+a5HFKR7Tp
	 kOOddNrESCk4RcqYR5+/6j2+NMvy0FMbWPLBoyvtojmuA7mdNWT/JuQzDKX+aIdln21lo
	 PmCekl3vmld0xTpxE2dNm1A/rjeoCClZUW+fA/wnz2EN3sXdhZXA3fry2dSbxzUfkFwXk
	 o5qDPe0Hxp0cH/vKwwWV+KFWiS78k5Q15x2Lk3ByXs5rDNbj9bup4c2xOLLItjuR/+HC2
	 bwZSXirBveA9dHiAiNnYvmIl7cHQulFc4RGF/CVzf5awELp42kS1FyeHEowcvcs1RsQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3zuwUCOyb76Ymn/gi8l4QRNIk29TelvZ3nlxYD11FmA=;
	b=djYtWBT6gwKGKBPSC8af7skvtssTmOWnfggEw80C0lmdkV8q2w00aRcPcsdXKUSMbdjv
	 MUrXdl4zKhUPtILMetFdKH+2LcxZmKTzDfqmB3NIVSy/wiHMqMrgxDt5rzgutCqNnMoLo
	 0djLSC/u2A+QaCjh3a8t6ETF+X43ecPAVFAmN7SrOXxwRe4WjGrhnrftDRjVuF4O6q8z3
	 QYLPO1AvmgZVWaYk/u8mAkfUHdzzxuxVzwXCB/bUczXFpuw+Au7eUqf24DLDfSh2qvWQO
	 6Cic6/aRJLsDTqgtVeLewL68Wg/Ej8YSHzY8RG+X5s+9C57AiSzRyWGlke6tVpHtVwg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731560;
	bh=3zuwUCOyb76Ymn/gi8l4QRNIk29TelvZ3nlxYD11FmA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZUTAMTsd2vwyJRDL6tomyml4kTOfruLNFI/AzEKTkw/+fuw6//07vWC+6B6Ez7/qm
	 dofSDzXXoegujKTogI6Ih5Z1ca4WO1gtLlpnLEyUzugIm3Y+/adZEGexKfrho7qkFo
	 hu2/VB+QobwtqHWFtIDbAoBiioy3hyfLDpGUfiWLynmG3QSQ2HCvJuQ1d3yjoogHXu
	 /WqykTJi4UWhuHIpITTKGAIF2AEEVg1etbOovXkIa7oh037jy5PcTwLX8/iUpmc02U
	 dN8zstQipasznlvRxLO6j0SOA0qqXNh85ODsL0yqWBjn1GqEL3WTpc4X9mQGB3GXef
	 87j3YWGivu/7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F32D260664;
	Fri, 23 Oct 2026 04:59:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C78B1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82892409A5
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fIzpMdpjZi3l for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 00:43:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B499F409A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::235"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792716190;
 b=BH7jA+l7ihEz8Zhrp3ztQgMz7yRv3gP5vreuwMkzqnkGhbimDP7UJIlwTgBAj+m6So5h
 R2xBK9cuJKQtLLl1CrAaHRnd/qPOjzZ1gVQ85Iu6ZDxOZ93JTi35Ju5sHctYy/PyDhujM
 krV8z/GKLGGh+s6hKdX++Xo5uadxHMeTthvkXI329MWGIfk5exdETq8KerTEH5zEXPz/q
 QtZNi6nynVXclkwW8m8kNINK9lBB5E/0B/Xg6laYLkmJjmYbyBrp5kNqsuzdUjywXIEIJ
 db3KFBJ31NbeABZ+08z9mKmxNA3ewLSWYWXXBjLNxSltjbg3IHLgZCpM53AOukYhkBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792716190;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=3zuwUCOyb76Ymn/gi8l4QRNIk29TelvZ3nlxYD11FmA=;
 b=SnD8NC77GnwdAMF/icpOXGVkYF3BJAeiujpAmaM5QGhKQ86USQPR2Ytk+7zBYqLWxXQE
 EmYP7ESrVlCG4RG3NqvBUFoHG66J5/fPXKVOy8U8TtjcgYS2jUNWj3j4bqdf9IM8GHn2b
 OSu5cJaX75PLuoFP8PFo4zb+kHvL51Cv2ySfPDoH+/P4C/CWh+xbpRwqrCn/TKzyM/xrQ
 K88Lcrpu7Rwyxa77VZvrRs7FpEWERuHlx7peDwXs0/8a+eqw6OvIwtstNHhuwBba2W5eR
 7SylvDIYUbxOzS83ZPJ17X4CYftzmZcUnBpvIFrmekHb52kzb+l3KOoj6cLW5ri/yqw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GHLOE0uu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=GHLOE0uu
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B499F409A1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:43:10 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4af81963f35so299227b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792716189; cv=none;
 d=google.com; s=arc-20260327;
 b=UwD+ikXbn9SzGm8m8mV1AQt0397Gyq9r+HxL0krh8Ovs9zb7AquDSO0GAKh1IzwhF7
 bsxxju0WeTeWBGdZFAQEO+pRgzhIPVRzg5Wb4Ivjkt+DMU2zsh/C4kIC6c0FNQ04Avpr
 kJhwpSOhfm05n1HTsMk9qSHjqpmBTMhCkU4CFNz+fXLEj1wdDJXu4PpjhuCze0FSIkp7
 ALxg5Lq4WsiLKnPtbjA1MDE0tlwN7260s+xsb0BTSF844VIPBc9XkmcZVmHl5GLD0qVL
 N5RvnHxp3wwhSKedA26143p7JXBKnaURMs2HSNW+cJUBFfngFt6UVJssEzq9ZNP9p3ZQ
 sYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=3zuwUCOyb76Ymn/gi8l4QRNIk29TelvZ3nlxYD11FmA=;
 fh=mV0kw6I/4JmHb66EJj+32qea+EX60k8tsk8ykmVnSh8=;
 b=So8KRKn5dKA+T5uW121U0pUe1MdFbNLG1KZynZulhL1qkd4nMKNsU/PDB1Wgrl/EMH
 Xj61zilu2rmp/nq6JASZymKgVYa6mETkBeCUZiZ+TCaPh47gH4M+/E0xgHDdPOYoSOAn
 RklfUIMdkseQHdOVWU/PRGdTznloEm8X6V6MKCYeJw4v6mESkiFeERrTs5tXTyXVSloU
 bpjb4PM7t+t+WpyRUPNSK1f/C/M/n24YjcE/4HLBaWcSCRUVge2CHmQkZviSpzDyoXqs
 5HaZ9nsLf9VuOh5kDZGG70+sZQRY/CPCA9dWm01PL7mzWujO/4kOQtvC2JwJXs+M38iu
 CcXg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792716189; x=1793320989;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3zuwUCOyb76Ymn/gi8l4QRNIk29TelvZ3nlxYD11FmA=;
 b=GHLOE0uuR8TmiNhzBMLCVijIfP7FeOx5NusvXra7/y/M8OvyAI0IOKEWK+zdhvbbZz
 zaQhU+cqwuNQHemxcX/QQdrarJXnOQrZHoggB5wn0+dpVdOCtQ6GZkxsab5/0CqBhsU/
 h2azYNRSP1PYQFHZINP8ESDQvFVEA5qH9BiHWqRIOKHsRBMJyqOeen6iL01TQtokEIIK
 jYFJdl1FuDOonifG0oOUTm8U6+azjVjfli2HHa9tlmyRglFgO2aW6Nsav8lxVI7TIa3r
 utuNsJryarLc/2P7YEo2sW1g7YC8/YY9fUYQWtD1XAXHe8bmpp/891NPYwpQkUjPVd1m
 QoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792716189; x=1793320989;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3zuwUCOyb76Ymn/gi8l4QRNIk29TelvZ3nlxYD11FmA=;
 b=WbdZTR320m8kX6p8B0Czt8ihk40cbPf5ILTcD35jVnEjY9+RwRSJEVzQlzzDegnKYg
 C7QrTCKZZUefoaCTP3IHm/YKj28X+5X929ro7jABPGwCt8o7FBv8H8cnHbqmpx0UqJ78
 B5zYbC6gAov5ErUA4iwl52DYq7vsROYz3AnAu3urTJCPQT41CKeFVTp68vdPeLcfJr0c
 f7CdoiZqz5qIzsu92vA2zLOjCsb9JGxwFNrWfsZYl1+7hcff0y73idg2GIQOgP2jCR61
 b5FfcSfKFJhkK/NxuZ1aF5a8Rb9rptsfF/CmcH/xzcGVLX01OIsmhWqL6Liq3hrqmdLt
 XHgw==
X-Forwarded-Encrypted: i=1;
 AKwUvByjaeBGAz92WYOEbSBGcP7LR7dIg1aZNE8kDFLk+Xq7V6ui0dU47fKstmYnT/ktjzK9FBnJrm8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIsP0RadrafCaseEUuV2Rz4fzNOIzWrYhJQdbAL1ykbLn5cb9Bx
 AxI4hO5Uw6ktqOBgjRnJgUHJPjVJURFNXRqm1RTjhHOOSnT3AC/IW2bgiiAh1PNqPQLcdgz2Gg5
 QG59Oixy6gGJV5laeBUQ0VU5B4l+6if8DiID4
X-Gm-Gg: AYBFou2e2FYvyhCXLCua1bV6KqT/+Vl+xxmWO6qdaVlfsNQ4lBujB1S4nsqlOdU3bSD
 DpUvc53KElWuifKHk8j4Vl7hK3TKEB+lweynDRVXDAMWiDIDg0e2+aLgsZPwUAz9eM5hal9sVTI
 KHXmSEo4rZ29pJwjGUujlrDWcYCSGWyE8SH9fBYnv40hJh9dP1RCYwr6ApFrKJjhtqBoe0J6vfD
 ZuLaB2O4sD737DMdvPITe/2Op0pxx5+GdkrPAreXr/e4FqZkj489/zbCJuSaA4yj9ijt+Fj68jt
 8xxxXlfIet415wqXwQ2W0m4+UrWMCvjyg//8cSWTdcie8Q3KfSpu3ZdQIB1R0rEGPGtdl/VZxTG
 s7kHdZsleFoSX0qNn9O5R2CE=
X-Received: by 2002:a05:6808:c296:b0:4fa:8d48:3a5a with SMTP id
 5614622812f47-55be82cc072mr530160b6e.38.1792716189532; Thu, 22 Oct 2026
 17:43:09 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 17:43:08 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 17:43:08 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsh9KDHJJFK5Pf3A0JUaNb0bK-hDZxzGpx89xMJ5FiKBLg@mail.gmail.com>
References: <CAJnxHsh9KDHJJFK5Pf3A0JUaNb0bK-hDZxzGpx89xMJ5FiKBLg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 17:43:08 -0700
X-Gm-Features: AclHuK-4zaZ7dGg20A8MKPFpwwcAVy0KpkA8WUPQD_9gijtbxpVcrdVpaWX06Rw
Message-ID: <CAJnxHshrrSd=x2qCvP-eVoBq0Y+8fmfw5NA-LvyTTG_8=znYQA@mail.gmail.com>
Subject: [PATCH 3/4] usb: eth: lan7x: Account for the whole rx command header
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Content-Type: multipart/mixed; boundary="000000000000a92507065e7743e4"
X-Mailman-Approved-At: Fri, 23 Oct 2026 04:59:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000a92507065e7743e4
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--000000000000a92507065e7743e4
Content-Type: text/plain; charset="utf-8"; name="3.patch"
Content-Disposition: attachment; filename="3.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6eb13d015f908071_0.1

bGFuN3hfZXRoX3JlY3YoKSByZXR1cm5zIHRoZSBmcmFtZSB0aGF0IGZvbGxvd3MgcnggY29tbWFu
ZCBBLCBCIGFuZCBDLAoxMCBieXRlcyBpbnRvIHRoZSB0cmFuc2ZlciwgYnV0IGNoZWNrcyBvbmx5
IHRoYXQgdGhlIHRyYW5zZmVyIGhvbGRzCmNvbW1hbmQgQSBhbmQgdGhhdCB0aGUgZnJhbWUgZml0
cyBpbiB3aGF0IGZvbGxvd3MgY29tbWFuZCBBLiBBIHRyYW5zZmVyCm9mIDQgdG8gOSBieXRlcywg
b3IgYSBmcmFtZSBsZW5ndGggdXAgdG8gNiBieXRlcyBsb25nZXIgdGhhbiB3aGF0CmZvbGxvd3Mg
dGhlIGhlYWRlciwgaGFuZHMgdGhlIG5ldHdvcmsgc3RhY2sgYSBmcmFtZSB0aGF0IHJ1bnMgcGFz
dCB0aGUKcmVjZWl2ZWQgZGF0YS4KCk9uIExBTjc1eHgsIGNvbW1hbmQgQSBhbmQgQiBhcmUgZm9s
bG93ZWQgYnkgMiBieXRlcyBvZiBwYWRkaW5nIHJhdGhlcgp0aGFuIGNvbW1hbmQgQywgYW5kIHRo
ZSBsZW5ndGggaW4gY29tbWFuZCBBIGNvdW50cyB0aGVtLCBhcyBMaW51eApzbXNjNzV4eF9yeF9m
aXh1cCgpIGhhcyBpdDogdGhlIGZyYW1lIGhhbmRlZCB1cCB3YXMgMiBieXRlcyBsb25nZXIgdGhh
bgp0aGUgb25lIHJlY2VpdmVkLCBydW5uaW5nIHBhc3QgdGhlIHRyYW5zZmVyLiBUYWtlIHRoZSBw
YWRkaW5nIG91dCBvZiB0aGUKbGVuZ3RoIHRoZXJlLCBzbyB0aGF0IHRoZSBmcmFtZSBjYW4gYmUg
Ym91bmRlZCBieSB3aGF0IGZvbGxvd3MgdGhlCmhlYWRlciBvbiBib3RoLgoKbGFuN3hfZnJlZV9w
a3QoKSBhbHNvIHN0ZXBzIG92ZXIgb25seSA0IGJ5dGVzIG9mIGhlYWRlciwgc28gdGhlIHRhaWwg
b2YKYSBmcmFtZSBpcyBwYXJzZWQgYXMgdGhlIGhlYWRlciBvZiBhbm90aGVyLiBTdGVwIG92ZXIg
dGhlIDEwIGJ5dGVzIG9mCmhlYWRlciwgdGhlIGZyYW1lIGFuZCB0aGUgcGFkZGluZyB0aGF0IGFs
aWducyB0aGUgbmV4dCBoZWFkZXIgdG8KNCBieXRlcywgYXMgTGludXggbGFuNzh4eF9yeCgpIGFu
ZCBzbXNjNzV4eF9yeF9maXh1cCgpIGRvLgoKU2lnbmVkLW9mZi1ieTogQW5hIEJvYmlsbG8gPGFu
YWJvYmlsbG8zQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL3VzYi9ldGgvbGFuN3guYyB8IDMxICsr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIGRyaXZlcnMvdXNiL2V0aC9sYW43eC5oIHwg
IDQgKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ldGgvbGFuN3guYyBiL2RyaXZlcnMvdXNiL2V0
aC9sYW43eC5jCmluZGV4IDBhMjgzNjE5YWU1Li4xNGMzYWNlNGNjOSAxMDA2NDQKLS0tIGEvZHJp
dmVycy91c2IvZXRoL2xhbjd4LmMKKysrIGIvZHJpdmVycy91c2IvZXRoL2xhbjd4LmMKQEAgLTQ0
Niw4ICs0NDYsOCBAQCBpbnQgbGFuN3hfZXRoX3JlY3Yoc3RydWN0IHVkZXZpY2UgKmRldiwgaW50
IGZsYWdzLCB1Y2hhciAqKnBhY2tldHApCiAJICogMXN0IDQgYnl0ZXMgY29udGFpbiB0aGUgbGVu
Z3RoIG9mIHRoZSBhY3R1YWwgZGF0YSBwbHVzIGVycm9yIGluZm8uCiAJICogRXh0cmFjdCBkYXRh
IGxlbmd0aC4KIAkgKi8KLQlpZiAobGVuIDwgc2l6ZW9mKHBhY2tldF9sZW4pKSB7Ci0JCWRlYnVn
KCJSeDogaW5jb21wbGV0ZSBwYWNrZXQgbGVuZ3RoXG4iKTsKKwlpZiAobGVuIDwgUlhfQ01EX0xF
TikgeworCQlkZWJ1ZygiUng6IGluY29tcGxldGUgcGFja2V0IGhlYWRlclxuIik7CiAJCWdvdG8g
ZXJyOwogCX0KIAltZW1jcHkoJnJ4X2NtZF9hLCBwdHIsIHNpemVvZihyeF9jbWRfYSkpOwpAQCAt
NDU4LDE4ICs0NTgsMjYgQEAgaW50IGxhbjd4X2V0aF9yZWN2KHN0cnVjdCB1ZGV2aWNlICpkZXYs
IGludCBmbGFncywgdWNoYXIgKipwYWNrZXRwKQogCX0KIAlwYWNrZXRfbGVuID0gKHUxNikgKHJ4
X2NtZF9hICYgUlhfQ01EX0FfTEVOX01BU0spOwogCi0JaWYgKHBhY2tldF9sZW4gPiBsZW4gLSBz
aXplb2YocGFja2V0X2xlbikpIHsKLQkJZGVidWcoIlJ4OiB0b28gbGFyZ2UgcGFja2V0OiAlZFxu
IiwgcGFja2V0X2xlbik7Ci0JCWdvdG8gZXJyOwotCX0KLQogCS8qCiAJICogRm9yIExBTjd4LCB0
aGUgbGVuZ3RoIGluIGNvbW1hbmQgQSBkb2VzIG5vdAogCSAqIGluY2x1ZGUgY29tbWFuZCBBLCBC
LCBhbmQgQyBsZW5ndGguCi0JICogU28gdXNlIGl0IGFzIGlzLgorCSAqIE9uIExBTjc1eHgsIGNv
bW1hbmQgQSBhbmQgQiBhcmUgZm9sbG93ZWQgYnkgMiBieXRlcyBvZgorCSAqIHBhZGRpbmcgaW5z
dGVhZCwgd2hpY2ggdGhlIGxlbmd0aCBkb2VzIGluY2x1ZGUuCiAJICovCisJaWYgKHByaXYtPmNo
aXBpZCA9PSBJRF9SRVZfQ0hJUF9JRF83NTAwKSB7CisJCWlmIChwYWNrZXRfbGVuIDwgUlhfTEFO
NzVYWF9QQURESU5HKSB7CisJCQlkZWJ1ZygiUng6IHRvbyBzbWFsbCBwYWNrZXQ6ICVkXG4iLCBw
YWNrZXRfbGVuKTsKKwkJCWdvdG8gZXJyOworCQl9CisJCXBhY2tldF9sZW4gLT0gUlhfTEFONzVY
WF9QQURESU5HOworCX0KKworCWlmIChwYWNrZXRfbGVuID4gbGVuIC0gUlhfQ01EX0xFTikgewor
CQlkZWJ1ZygiUng6IHRvbyBsYXJnZSBwYWNrZXQ6ICVkXG4iLCBwYWNrZXRfbGVuKTsKKwkJZ290
byBlcnI7CisJfQogCi0JKnBhY2tldHAgPSBwdHIgKyAxMDsKKwkqcGFja2V0cCA9IHB0ciArIFJY
X0NNRF9MRU47CiAJcmV0dXJuIHBhY2tldF9sZW47CiAKIGVycjoKQEAgLTQ4MSw4ICs0ODksOSBA
QCBpbnQgbGFuN3hfZnJlZV9wa3Qoc3RydWN0IHVkZXZpY2UgKmRldiwgdWNoYXIgKnBhY2tldCwg
aW50IHBhY2tldF9sZW4pCiB7CiAJc3RydWN0IGxhbjd4X3ByaXZhdGUgKnByaXYgPSBkZXZfZ2V0
X3ByaXYoZGV2KTsKIAotCXBhY2tldF9sZW4gPSBBTElHTihwYWNrZXRfbGVuLCA0KTsKLQl1c2Jf
ZXRoZXJfYWR2YW5jZV9yeGJ1ZigmcHJpdi0+dWV0aCwgc2l6ZW9mKHUzMikgKyBwYWNrZXRfbGVu
KTsKKwkvKiBTa2lwIGNvbW1hbmQgQSwgQiBhbmQgQywgdGhlIGZyYW1lIGFuZCBpdHMgcGFkZGlu
ZyB0byA0IGJ5dGVzICovCisJcGFja2V0X2xlbiA9IEFMSUdOKFJYX0NNRF9MRU4gKyBwYWNrZXRf
bGVuLCA0KTsKKwl1c2JfZXRoZXJfYWR2YW5jZV9yeGJ1ZigmcHJpdi0+dWV0aCwgcGFja2V0X2xl
bik7CiAKIAlyZXR1cm4gMDsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2V0aC9sYW43eC5o
IGIvZHJpdmVycy91c2IvZXRoL2xhbjd4LmgKaW5kZXggOTQ4MGY0ZjZkMTUuLjI5ZjA2YzA3NmM1
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9ldGgvbGFuN3guaAorKysgYi9kcml2ZXJzL3VzYi9l
dGgvbGFuN3guaApAQCAtMjMsNiArMjMsMTAgQEAKICNkZWZpbmUgUlhfQ01EX0FfUlhFCQkJQklU
KDE4KQogI2RlZmluZSBSWF9DTURfQV9MRU5fTUFTSwkJMHgwMDAwM0ZGRgogCisvKiBSeCBDb21t
YW5kIEEsIEIgYW5kIEMgKG9yIHBhZGRpbmcpIGluIGZyb250IG9mIGVhY2ggcmVjZWl2ZWQgZnJh
bWUgKi8KKyNkZWZpbmUgUlhfQ01EX0xFTgkJCTEwCisjZGVmaW5lIFJYX0xBTjc1WFhfUEFERElO
RwkJMgorCiAvKiBTQ1NScyAqLwogI2RlZmluZSBJRF9SRVYJCQkJMHgwMAogI2RlZmluZSBJRF9S
RVZfQ0hJUF9JRF9NQVNLCQkweEZGRkYwMDAwCg==
--000000000000a92507065e7743e4--
