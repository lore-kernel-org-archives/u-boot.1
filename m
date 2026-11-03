Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F9606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Zh8NWgRK;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZVc7KNLm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77DCB8096F;
	Wed,  4 Nov 2026 02:05:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e7HPFWOPiWTx; Wed,  4 Nov 2026 02:05:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BAEF780A58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793757958;
	b=oLqYl1CifX2Sf76On+EmIKilX2aN65vR3HqTduFjMtqYs485r6piSRyMW4kArJs8GzaP
	 hx3XNvptxBlQlA2zFO0FGJuUhBisKs8/+YpWRVmJlUP/9SgALWbYNFEJLWCJH9MCm/pEC
	 n3qYfN9nhP9lBhWkhqp0sUQYH9hg8xEo+RvS7Nb/6usJfOPUqe6E5+0h+WeLw9KOtBe0A
	 /te12FRymJ1OdgEZ1b2F2ayJ05jjA6oHJNYWGNwuKmKihaLIQq0/klWoNbfrqEzXWVvTm
	 uFV7W69SVAMHTTUEO7j7dr2cLTHG+h0gYJfzgaRlHHxZOSflGDA6L6E2LPtZeEsgvJQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793757958;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=c9u1Q+mqpZTm2F0YgUMPTIV/Pw7p3WzZo+xYpHp0wuw=;
	b=fDQSMQJQ5ZoPqjpK52ulMR4IoX8QuRQWGnhxQMfQpFx3HZ0W5BRYmzFarqBhmwsoTaVc
	 1uA04THvFhZbtDpFhRg97ZLPg6PJmdWnb4kzh+5enOh+HaLwNSq5lDRqV/wUEfIO/D+A/
	 X4/ix87TUf/SwmUqNOhLKv493+EGd76S0WSI1faxg6SVpn5OIa8fYZIRVM+MfmZfGJlMr
	 PZtFQF1TuaWbyOEcnVeKwLm+YFqXgH521hnuTC3DlbpOTzZAvddkkGFjfi4GEeeRWpAwo
	 KaadddQBSOIxazgMUudOUXSfCH7dBd+Vuuv8b4ugHM0hVAXWRzBZ6roxph74xYbm5xg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793757958;
	bh=c9u1Q+mqpZTm2F0YgUMPTIV/Pw7p3WzZo+xYpHp0wuw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zh8NWgRKLzsSwux/2pBQjMdNWdta9zCA8mKF6SyBSXYLPt2tV5LsVgEMhF619pi8W
	 x61gK8KhtYGzOTRlw/kmQdiudSYjT/wZ30okjUFZTuuZvmsKkqRuyAudFgXySfewYQ
	 5KyBtDBOYraPUJ2t5qrFiSJRNeN4iIoDgeKHElQmVK52/Fn8qkr0LmzlIUw2Us2EKH
	 sfg/uymweDFtq8yeDdbL42uytQe1s5s6yga7HmjowFspiPgNoPv2h/4fiK7yzV2vKP
	 sRB+T3nA2LXGCIpbN+FS0kRK7LllxQapw63EHZilVmtA3UM4JI6UC00TvV4IjBYrXQ
	 pGPa8EZzQS3Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAEF780A58;
	Wed,  4 Nov 2026 02:05:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 19D0C2B6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 22:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16EC44008A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 22:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id opo3HhRJfZvK for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 22:44:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F152140048
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793745865;
 b=hG7FdK1JNicGxQiwXurLEUAWeXFlzfaXXVSbp2aEN3WRrrZt/lHQzZNyL3uBHUIgvCVD
 6cxLjpE6kKViH60TxXWT53TrdjAjeP+5Mz8ZLjGRrS+2LbRTqZRhcipbSs8Uf5MFauwvT
 EtJs/8FQFAuTt28JB+6/k9p0vwkG76k8d0tWQyQ4r16sQhflnC2CPQFRljUDCP0ITJcy+
 XiMl+4Ys0OpVIsAs1yw8NjNXHNRGr6g0ze8JR8fNi/8zrn0x2bGf3W8/YmPmZ/nFqHoEs
 w5+N815w4yc5blI5a6wQXrmkC3AUfD4jG3QzlV+cPVuzEy+pbqtw26M/R9lj6BO/PRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793745865;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=c9u1Q+mqpZTm2F0YgUMPTIV/Pw7p3WzZo+xYpHp0wuw=;
 b=hvZqbdUKX4HN7OaCqGgHte2aWKEk9dVWbnEUQh5XNCkPinMXe6W9PZ6PJiSKIfojhADJ
 jbh8TRCqSbemakaQ4+3Hy7pRhT17q3cpIIZmbKPMetSYiTL9bo0lmKo/qK1Maub8pis/X
 FvVAFbmCyizqH2mC4UBZ/vCmUaaA+fa/xzWOZIYCkNbHvWQyzApALF8fij+/zVlzrPt3I
 HZIcA/Sh5pHVPve4XCn1IwvkfURPS+1R9yyFxFa3u+QyjA8AIpWjnHRYGTwlLa1352yas
 8uJvFSKBGI8nKA9C3+E6nZvSo38HhwoYzH7nyWBRgby+RPTANTBvNtZvnh+aGxN7nOw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ZVc7KNLm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ZVc7KNLm
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F152140048
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 22:44:24 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3ab3dd9667dso1150491fa.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 14:44:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793745862; cv=none;
 d=google.com; s=arc-20260327;
 b=JxoZ0oYxiy4iAeg3S9pLeQmJXiMRoJpT3mDhhnJydEZW3N0IuM3ulJnZIUfAHSWqws
 AbDaHeoHQ9AXsBmfWrhmUGsNrHZIdRBJzMV152brohpWTO7AYyfCvy2jQb+zoWRN73rb
 VZZhX+WFKrB9SjiJex/QqLSGEZyQOffJ91jv8Vba/h7DNaFW95XKv5mOVb9NBGiTEz+W
 ltFIHWfBdu+p/K7WkRVQkAv6hF4kLpekQxu4GvkAxcj9AITbis0piCG10uiXfHtSP6ij
 ePEDXRZ9lMW+BnZwCn61jYQ0CKhOOKx1pynME21Lueodb/gL6zm4/zPKeNSQrdfN5T48
 lZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c9u1Q+mqpZTm2F0YgUMPTIV/Pw7p3WzZo+xYpHp0wuw=;
 fh=FtAg2mNJoACBragJzpbQ7kQdeTyY+X/xoxwTWr3Tpnc=;
 b=H4gUhyM8lMuk9QGLOffGGuCvaPLbGRvMinLdZCGBykrWQV08zkgFK4FsPu+X3hVbx2
 cCmucMBK5DQjYqrxBr0aFDniUN0zKMyA7KPKFvyXLj4vYCKf5vFS2YoY1D2byJAfdldC
 Ozc58j8vRqGBk9a4Aopx76R589V9WqkvVCT3BF2f7QJxByv568zq0hHwvW8Q6y/6Qg0P
 VWoSYFcK+uqF2UxbczSGVGtpH+DjNza75sBWUHAMk0qP6YmHdI26nJytrUnCgNILqcvs
 417asGs74MN6Ou2kdz89JwjEBwGreR24LStz+lPLJiSdgtcccSeExgbOpDeoKag0swOi
 AbGQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793745862; x=1794350662;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c9u1Q+mqpZTm2F0YgUMPTIV/Pw7p3WzZo+xYpHp0wuw=;
 b=ZVc7KNLm7AcFj9f+e2sb3lzOcsPCg2SxejcpjL8qeg5WeHpUQ39IXiVfF3HzGIWNdM
 /lKc6NN1SpupcGpDIKAkicfWVLrb+JNl/jWAyupEj/ghz4T+NqtAzSdrj5NHew625srk
 rSC7LM3jLOjpNc+3wJmktRmHrA/2PD7tZCxcOmge0wF0PFF0lchhMPb3t2Hj96cncZ8O
 MRQxiSdjcyQEmcqOzviNcTPaD9dvu1Gz9UVzXe1JpgTFWewX0suFNqKKEc17pMY0ouXg
 fy8nNQcWBlEviKOtI9r5fKUE6lT49xmTjytLBlCUFqmSjOByhP/r2+/9tzyMiVOuAsrz
 +9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793745862; x=1794350662;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c9u1Q+mqpZTm2F0YgUMPTIV/Pw7p3WzZo+xYpHp0wuw=;
 b=q/k1tksJethhrxUFZvMhEawFhuscYCEWpx8xv2qXv0lLfUzkrHCteE2qwAjaSDB/ju
 kZ55fm7StPDMIkYeEBCWFuXTCfAPTKQVnBmxz1FXoZQcTIDO+B/Fm/UJFYv1wPo2XCnu
 uaiBCehOMexBMKQsmVvj7hyOGjSykmioXCcAni4y1z0s0/Qan4FgS+ntWg3nfZR/V5Rc
 QXYng5im1bdc2CsFQRlK9tNARRitm2FJtBjd+s0nNJxwF2/67A+2mRvBH/rjGaOAklQo
 3pNRSBc+XjFKBhhp9kafBWTxZCsmfp0wnYC0GmW6enQ6Hzml/t49gYFEv+1KeOLr/cwb
 t2eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxly3cg878AMdAkj/icNM1agtadGDWp8wCTQtcnFWcHxX6OWC3uH40Z3jH9E5qMISzqOsGnUcI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+utdl+prawlPJ4gWMJ1YNZIOD0wyCjqVYPok73tgiMEenZ/pyy
 9Qzuv7O+pmdLYbPQZ2qnVne9tCzsVEWepqGGlQAJ7xnjXUqf0SbllJq3mqOMp21+JRbtYZx3Zvg
 ZVfLWi4wENl9zQbtKDZjaVLYpqWxOF9ZDUntX
X-Gm-Gg: AYBFou1fRZe+RRghWnqg00wrHaF2dxyoo3BvtcdHMNBOhcFrSSedTivI4X/bTpYo/TF
 MkwepzulZg1bBsMy1F10ISNcYeGkqaiv+W1W5SxGzK04s//t5fKQ5CqLPfXu8GMD7hknl+CugCi
 KX18mntcNbdN4urcwo4ynXFQY8+K/KSvM4ZczVPzHtMYLAZmb2a6WodAMFFVVM1Wv+dktbRkr6s
 PuSvbMT1FKdmjkobl2DTj1q88Ms06fcDL75ATT+0jSneRDs+lCrjKhRB0uxBjX9qhSkd+BCbTjv
 gpGvy9Loyzf6OHlSX9ctowTmIugh4mcKPIF8RN0DBWIEUOIYFeo+FFaDYIaj+Qn5yQgvgdN2WRb
 Fs2zXYYZq2iRa+tMpaJcME3lev3UjJ/OfIalYUqttAQ+7DybHaV1baPK/Z58=
X-Received: by 2002:a05:651c:1991:b0:3ab:43ae:ac2a with SMTP id
 38308e7fff4ca-3acb7b14139mr36290411fa.26.1793745861689; Tue, 03 Nov 2026
 14:44:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026030925.1002846-1-oss.patchbox@gmail.com>
 <20261103193614.1250525-1-oss.patchbox@gmail.com>
 <20261103202219.GB785819@bill-the-cat>
In-Reply-To: <20261103202219.GB785819@bill-the-cat>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Tue, 3 Nov 2026 17:44:09 -0500
X-Gm-Features: AclHuK8vCO8TAgIlVI32KyTezjz3aixCq4PsdnXTcjXSEXpTQ0jNwg9ikhdMjTY
Message-ID: <CAGG=RgBCeZca+58O1qsK2_tj3MZNVdZEw29WEA9SG5BVwXCKXw@mail.gmail.com>
Subject: Re: [PATCH v2] dm: core: Unlink the device when bind fails without
 DM_DEVICE_REMOVE
To: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 04 Nov 2026 02:05:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 15:22, Tom Rini <trini@konsulko.com> wrote:
>
> We're sensitive in SPL to size growth and it's ~500 boards that have
> SPL_DM=y SPL_DM_DEVICE_REMOVE=n. There's also the expectation that in
> SPL things may not always be as robust, since it's going for just enough
> to get U-Boot itself running. So what was the real case that v1 didn't
> solve again exactly? Or was it just a code-cleanup that Simon was asking
> for? Thanks.

Hi Tom,

I appreciate your review.

Yes, v2 is just the clean-up Simon asked for. v1 and v2 behave the
same: both take the device off the uclass and sibling lists
unconditionally. v2 only calls uclass_unbind_device() instead of
open-coding the list_del().

I also don't have a real SPL case. I found it during ongoing research,
through static analysis and code inspection, not from a failure on a
board. The only reproduction I have is sandbox U-Boot proper built
with DM_DEVICE_REMOVE disabled, with the multimatch-test node
in test.dts.

I didn't weigh the size cost against the number of SPL boards it
affects. Rebuilding xilinx_zynq_virt, SPL grows by 58 bytes with v1
and by 64 bytes of text with v2, so the 70 in my note was off.

If that is not worth it for SPL, I'm fine with dropping the patch.

Thanks,
Yuho
