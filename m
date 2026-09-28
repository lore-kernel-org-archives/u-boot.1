Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA73CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3550605B7;
	Mon, 28 Sep 2026 22:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yn05pxetTDl2; Mon, 28 Sep 2026 22:43:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 50E4F60614
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790635391;
	b=R0w6Jf8XMNBWeZ+yrZbwGEbhhG7EnPymZaA/DfcPN2S06uR4MpUjRkdy6Ty+Dw4cNVc1
	 UnkW3nHxJ+lLldZkwddWJYyvEtDosGLmQJYOIgDQ/cwp0iPJTi2cxOou1HFxJQEWzQn/k
	 AFLvBMxk2itXjkvEJFa63VQBqxl0ZJHEbz0qvMkEqs97MP2bLUJlp1B/N2/YTQTnNbEAf
	 Ny0Mtay7xlz1mRjiVXkTTnc4CvJOKYF8TTMuz/XrT3lfHe7pMmAUR6EzffiAbrHAM0q3l
	 HYiSVlMLMFaqqhCZBrcNc7JAEMYMDMlnHUc4eCED0+OlPq0XN9NIH5kTvPLchbin0JA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yMiiZJOUsAEWOCUrQdh1LLz/FPxjw5u6aP57HYHwDI8=;
	b=oVDP6fu/zrVcK9sFciS5qKH5WBxfGvBur7YIEt8Cd/+4lVLygr2S9CgsHVhlokaw0bx5
	 nyDLKhGoxRwEJ3ExsZxOwoYyh3Bv5NJCaQOuMWH97RTAeR7PIsrfORDFSn9tiQj1SmrId
	 XxlUAWzyD/evJ9ksBbTOODXtdHUyenFmrQxIVZBUKaN5ckceF7v3A1P8ohIo/gUWi2Qlg
	 PHzleVNPWgPwSk3CFtuX6ElwgLC3a2X1gSFn93WpIG64YKoOT2IEpp7eWLpw4TAfWhdU7
	 VyzRIzNEnL/CwumFo5cslTkShGxMOdANaNoTt+n2lI+fcQwgOXg6/s1DfCzIdzC2XFA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635391;
	bh=yMiiZJOUsAEWOCUrQdh1LLz/FPxjw5u6aP57HYHwDI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QgNLUn9CG38tSIz/xk53Iisz4oBSv2K8M3p1oT9GrL7vdga4tW3Dv+jXhat/6V0O8
	 zoaLrSo1Bk3vbiy86vXFvKZ638UaLW/CFSoUi1ArrI47RX+Q64zf+dDFuAL49Z7erT
	 Mv4a+gwBtxGItAbYe+gMlTyv30BOwH4WOEUotIdrKDC0JPRUNlxxF6ZTS0Ld3/WkBi
	 /I8rn+gAquDLOQPyJUPXB8EUXtCIpeA8CewzfzD8rs/VdR2pnon/UPhLT+ZGLnWmYB
	 Q5jmoJ1t8P4o4UDAbEpgiEcpVlnHv6Cv0GSTXGohFF6uQy2KE4ONpl8DEpVOuTLvCJ
	 bmlUyJZ/d76vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50E4F60614;
	Mon, 28 Sep 2026 22:43:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C404B417
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B589240090
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHuhFWNo87aE for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:43:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 235D84008A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635389;
 b=DAxmev8FtLoLNN6D/ydO4GyIqmaRMn265n72OGEsWQ1MXKiKoNfTp9K20ObWkypN1Evn
 71XfxzCWt/vHQkBVPeMlKgC+yROLa4MwNd75madOTkuFC9CjkKIOqVMLukQNiaPABtkrH
 kfi/XerxBe/LZEJnY8JhuNMv79dAviMcnbwSvukleXVDfzeR55CCLSof3kcV4dbiHFwOM
 ubYcixMTpgK9ZxR3nMSs25fs81hGg5BWamFJvqufL65+Q1i0oK5o/wOc/LEbrJBo7b/Jn
 X5sHt/5Wein4Oz4guDcINOZTedp7G1pm+N4kqyGEYML+bFInareafwQIICU4kdDZszg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635389;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=yMiiZJOUsAEWOCUrQdh1LLz/FPxjw5u6aP57HYHwDI8=;
 b=JGoyPLCcA/XDBoCl2V6WCtTR1rwpPLXdxxOqBPgDgfVtBrZZjbTZWmZDkHdLsGxA2cAF
 Okn++xjbFT9Jh39OkNWzs7QDfclIwbIhNGIZQoYmY8JVp3T45YyjPBFIcVWyFr1pvCNFm
 j3WkLgKCPM+ar9/EQNDYFwlaoMU1uPbAycRRpr7ss2oy7WuDzpDr5HHTZMsESBS4nqe2F
 5yAbLWcaIKmSpAV6E1c7P2Y7j0FynIUuvEgWWeMKbzVPaYQauB9Lxqmmd1o41FDxDjeaC
 +oNhNlO2YJTQSVSOtP9DQ8Fl+T4c5/KHOJk7YzSPAjS+N0qV97XjqpVSFZutWAt91rQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WdehQ8ud; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::f;
 helo=mail-pj2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WdehQ8ud
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com
 [IPv6:2607:f8b0:4864:39::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 235D84008A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:43:08 +0000 (UTC)
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so1965501a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790635388; cv=none;
 d=google.com; s=arc-20260327;
 b=Zye4Qmlyb8pXjTtv0dQVF3jsSiXAeWXYir+oMqalEn3SZ0qOhMC8bZeZbsc8m0aPYh
 s7ck9N3G3nRpecpO1sXkQlA3lFPBH49HqMY+y7Qxm14pnzOkOpe/3QDWve/+XJbavDOI
 dkfC/J+apErwHqbaqVt3qc73c0dtqLyEBxqy5pKCZ3L4wCoFJRlUCjIC8ZwrhFw5/nB7
 bCKe08nV8ohvUZpe/7hyYGLqxELEU3ddpjcSPqE01tU3DdSaYm1v1qhc1DA4A77DZp0B
 90iCu/LTXTU9lihebY4qO+bPIPC2zeXr1PaoVWqzhcpoGd4NwfiKFLwkd1UMh/Pp8D7z
 FoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yMiiZJOUsAEWOCUrQdh1LLz/FPxjw5u6aP57HYHwDI8=;
 fh=xTpum0MfcObRVhFD21mnZsMyiAQ4WAlUJk+/bVjKVCw=;
 b=TxQq+/D0OQgCWfQcycwcFgQeSLjsKYOeCO8d0ARUl2c+e68L0ueylIRJ/3cynL01MS
 MR3BIwXaDtKQtQ3pPE3goc6xj4JS++8I3a5hrSPD0duf09mx4/fi4pecMDjHUECd84Z7
 f3wza/XRrLTMZhPgMBb6f24cskTqAognUR9D20ukFI9ewoeGhRKqeBSxZoKiSU+UBPP/
 k5vsrQQ7fgkWNyBt8ncxffUgpnMsN5AmYgfUFK1gR17EY8gwfpTHkt5V1hHgl/8jAPdz
 1yW0YsKT8qhHpUuw5c5M9tJSN9uX4sotiBVCJvhK5Dvcd/8Yd8Ws2cZODcR2SPN1hyv0
 P2fg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790635388; x=1791240188;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yMiiZJOUsAEWOCUrQdh1LLz/FPxjw5u6aP57HYHwDI8=;
 b=WdehQ8udeKQzWY7NWjlbyd8g3VDixD8p2cBcdWi/D6wS2iN2WlgiCHZE98Df308bY2
 E4VPMeX2bBA9JRis9+BjXCufafaXlferBGZCGtkUIbB3aBXG+ZCW+aC8LZ6aZkDP4XHh
 J4gi85sZsJ2KLZu/Vd/iTkDJOLs13FIL47qeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635388; x=1791240188;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yMiiZJOUsAEWOCUrQdh1LLz/FPxjw5u6aP57HYHwDI8=;
 b=FUyiArdgbCctN59w6xxEo/NJ/09JkzLxXrxO/fndGuYNHg8I3ccT+AhFPTIFHNUohV
 2yzbUCuesQXX7gcF5bW4QN3osX/V2tWbwVRB1DxmbtbFN2By8cAugmhLNrw3Gg3Hbi9+
 AjYq3tcnB1JBRCMbp4RSIZgVASfd5UGHRxMG8WAxgPBohin94sIgRTBtRiGxewOWIBxN
 MoRzo3BcEb+GNECCros8BTqG09nRvZLw6U19KB7l3rVSXwS3BzrC4nxPw0EDSLlzd+zv
 zd/Rfm0xwZVyQVBhJkdwp6WL1nGJTO+1n9cWPPKKCv3MFPLhKXxuqubwj6NEqHCKG78P
 2tYQ==
X-Gm-Message-State: AFq9FYL0Ekc9BE7MBG2sHP0KQ1ZQ+xao3JBT3ex1peVoCnxKyuXUZRDX
 kkGgybL/3/nMPSDJeDy8NdGwjQnSLWhQjFIKWJghyjs6tZA1UyM9dev+vSiqplSGG66z4hvDHK3
 J5SZMpoO67gmfvcGj/qzWNM0oqZHh3TOfEdtYBKtHdFziVvn5LGg=
X-Gm-Gg: AYBFou2TJ7pHypiMbw2K+0bS2QaIGMYw0F2aS7uEdcaqy9Q/MnSOfdvh5g42Rwyuc/m
 zvimZesC59wCPwBfHhkgsr0AlSx9J4Eef16Hhfps30/MH8D4AmuSC1RqQiUlYyWqY8sftcVxF+n
 /JRaafun8FdOzqO6U8imfTzj57xrvmZFX7eLvSGXyhRTwDt6htSWIFSaSA//Kr4Q61Gj6kNvX5J
 E5dlIHWftlkf6IAoDQ1Eot0H0UWSYnM2UQ9R2/Pp/o3BDWwyxYfM6StkDojtxdtAVPD6roh7tFC
 SQxLtq54JZ2ExhvBZlsGp2uiQSMdukQaU/BwZAHZOOk5j4PW9u+93dAc43JespmIryBM
X-Received: by 2002:a17:90b:1c92:b0:39e:6c68:c77d with SMTP id
 98e67ed59e1d1-3a098e0515cmr13114644a91.51.1790635388089; Mon, 28 Sep 2026
 15:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
In-Reply-To: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:41:55 -0600
X-Gm-Features: AclHuK97ZZEe7abMsRteN1x8P5zO4XyaIyuCbReDfPTn4UOwOrzhD1AlDX_U2tY
Message-ID: <CAFLszTjS29pfnPhORF0Uh7m_t5Xk=X_KBK=u0x2KvB1CZdv2-w@mail.gmail.com>
Subject: Re: [v1, 0/8] gpt: enable writing a full-featured GPT via 'gpt write'
 over fastboot
To: sumit.dhami@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org
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

Hi Sumit,

On 2026-09-28T06:40:33, Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com> wrote:

> Sumit Singh Dhami (8):
> ...
>   configs: add fastboot config options for writing GPT

I seem to be missing a patch? Perhaps a patchwork problem.

> No option available in 'gpt write' to set full 64-bit gpt partition
> attributes.

This adds a Kconfig option and a new field plus a 'valid' flag to
struct disk_partition, but the struct already holds the top 16 bits of
the attributes in type_flags unconditionally, so we end up with two
partial copies of the same on-disk field. Did you consider widening
the existing field to the full 64 bits, without a Kconfig option? That
would avoid layout differences between builds and keep the read and
write paths symmetric. What do you think?

Regards,
Simon
