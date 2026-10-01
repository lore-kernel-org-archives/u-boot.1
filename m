Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ABCCA5FC5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 625E88121E;
	Thu,  1 Oct 2026 01:20:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sK5nZi6bxYyM; Thu,  1 Oct 2026 01:20:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EDCEF81235
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817619;
	b=kB+fB/xjLPOMn5nPvOXNtsxKowGrLQVyxtqPoSCxjJaC487/I77wHiqsAOZFGuGDpHSn
	 7nQfjW+7FSmRmNKl4GB+MbtbEg93/bEnCvgaLgqGHjilfw8+Hozok8Ux74kMmBeGCgjnp
	 3xvQsElvcGrsWQhdaDAczFyXMfPdklOoSZw3zJj/9gJTAxY6jPXHgWaRmPt7yMkdSizGB
	 dgpGZNGlFU5gXL7pb4curYBPV8ATcFKEmm0XLsF6JSEU7eeZc3LxdSPVGu/pMBmSWErO0
	 Zdnz9NiAtTvmL7glROSPLb0qPrLGbCHn2UHZ/X8BQTPN2cI8FjB4UDHkEXG5iUQbTng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790817619;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jiFPFSHpRMux8YwcS3yCOf3xD0JRx+T7GGq92pDiv7g=;
	b=PDFWcBm80c1/iGNbF33uXav05IuZfQZL23joxbNrNaPIOeRIQH0IAGYb8WFRPgmF/oxl
	 u1LNCWnGlOnoM77BO0nb+nQ7DFP9UBuiwlrE4xRoDjqh1lLuzL2H4jw202r42rth8EZqY
	 rOvWW6hd5sNuAgtzLopTmSLvnycSuN/Fs12v/QQHnnxoiBblZ6kER1IKHHfiZ1r6DWT5q
	 HCtDdBhDdQWwHREorbeBJ49fowWlXg1aMVFAwp7y5RIDvZARCSgVE97RI0PLeBpUeLmuO
	 A5XkZ2ZSFyrw2bAzZXqjynGIFfWL/Ieo9QU52U3ZlVvWjkO3i5PnkLmr/0SLKhccUrQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790817619;
	bh=jiFPFSHpRMux8YwcS3yCOf3xD0JRx+T7GGq92pDiv7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ScRnX3jkG2dEEiJCxlYGURqCPz0xXcLRAHyn+ddUsitNM7vO1DpNU8P3k1CeRMD36
	 UmAei/DjQhQ1RMZlVWiWFUGGpboQ2QGvQF9us11hd+9mNNSfor1uW8UuxlcvEQThOV
	 2A+/TstVutr0/Igg6VXZHMZ9HfifoxmG2se9VbE93CxztCVGK0ReOMfMoOXdjqi350
	 S109Uzj6NEhxaxMe+FjdP7dNsjm/wU49sTTcZ+mvvkcwEqvhR2Wx6kaM1N1yMaw2aY
	 oJ2K/xr9Qgsf/sWOP/GzdxeccMVHQjN2dqetvOeR5HYJ0HveGH7Mv656apLVSQu+TU
	 mHyF02FrC1kqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDCEF81235;
	Thu,  1 Oct 2026 01:20:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B3BAC116C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A567960BAB
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4lH6UXW-jEiM for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:20:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F324860B74
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790817615;
 b=sbOWExPAU9tn+mq3czgmJ9W7G7D6mCaATc89EF4IuC1fRhwv1Ph5qL0Hbd6F3kGhiEN6
 kP+/xym+xy6mypLwZjQYf+h9hhXkIxq8ZDLuDUkFqku498N6vro7+X3tzfwwfUufUph8D
 A+vPQIiwVf544L33n+ug51fK2BW9rhqC8lDOMW6Y2tocJwVdyNxNeK13yMZW+CMinrWNe
 XV30N5kCnZTDr+FyWc1QFJRtQMpoI79a0dzs+71p9cjRrkrzHd6CDc7M9Ig4KwQFr3J2t
 n2na//IrYkYd0hDPTHV74ZNhSA+DgEdJvHO6E27cgjWK8sYDNkA3VZzfBGw0NkoPqkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790817615;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=jiFPFSHpRMux8YwcS3yCOf3xD0JRx+T7GGq92pDiv7g=;
 b=dRfzCeRxiveRem7WWm169m/GNJHASXwy1x/3LuzUgkaLxvcT/uvhX1l/8xpquhtKVmcp
 9IDUyX3UM8ealQkPVey28yozdDc1g2yVNXEKrHcPkZPUZU9+vDmNAY7Rfd8um2Hd7zqS+
 7dj9spnpreh5AFh9mJsqqbU1BbtocHBB/FhtyNHeG0hlxzCtu4zryztmBVfH6BzdBAW9V
 uqKOBj7aEcoQ6HtjaV/fF0yd3WbrpyCXPiZVtabvYau3jZn3lP2b3mD6ql1FskKJWkISv
 hbMhGbJeeTkT8qdgSpdMJDcaExrXjj0nzrtwomBl60NmUqBp8PFPP1ytWo1bIuiqn/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dhiJMsCx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::29; helo=mail-oo2-x29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dhiJMsCx
Received: from mail-oo2-x29.google.com (mail-oo2-x29.google.com
 [IPv6:2607:f8b0:4864:31::29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F324860B74
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:20:14 +0000 (UTC)
Received: by mail-oo2-x29.google.com with SMTP id
 46e09a7af769-805bf8c2661so4534045a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790817613; x=1791422413;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jiFPFSHpRMux8YwcS3yCOf3xD0JRx+T7GGq92pDiv7g=;
 b=dhiJMsCxWhSC3DrqrQxUKNhDLWuunSqNTZqfrIy0e7daGlyp/eshpSca9FjY5e4ctV
 Qmak2xNJIMJya75bRvS8Qcle07I/c6T6WbLH/+Iv0ehJZemEvKSK1MeW+0e6p70hceeY
 3DHXapnwpqXB/nmjf3PS/qvjHortKTCuWFrKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790817613; x=1791422413;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jiFPFSHpRMux8YwcS3yCOf3xD0JRx+T7GGq92pDiv7g=;
 b=MgVvjK1YzbVkQ10tH0N1O7+H7orMjBbze91xgXxK83DB1YgAYxybJyP8gWaMzNKcKJ
 lSdvRFqmvNCY/7kNDDXYkQvEdfEyRqfsvA45d8omFfrB3is13PLlOn0EwnVSt6Ia6EBz
 CIDiBbV1Xl+jB4zR6YHo+IagvgvWCg6wYkQBgD3ncrPGJapUEg5ctuxgFjan8RqY79vr
 +wJgLQO+Vbl06hMwgPyAfwNQJhmgKtm50by/uDK8eLk+i37O9CwO7l1aT+wLh1opCeCS
 4s31juaF3FQ+dQkVlrew8nApivzyNYpBJpkgIKI1l1TCnHRMJ131bvOGP++CEATGcpcR
 UWOA==
X-Gm-Message-State: AFuF++lLH42R/cHf6LxabhzmRExQDsoUYgGyJhI56IrNtWdN/SJIwuC8
 FvI3nKnWMkvGOADVE2Xc0NlHTK7Of7XMIbnATQestpAP2D18TSOE78MMlv266UtDNg0=
X-Gm-Gg: AYBFou2q+XZ9P6rT+zSaoCWI4e/K/Q8XfLaSrpGAyPrubSSOQchxyj/XekVKUtAKTKo
 tYRBJ6SbBgIDNazC1xDkK/HdwMToL5MxqROXVGGdEXL8iEtSFVBvzaR2jgdz7+fKJVV+dboZNP2
 LwYji1SSTdlOjBK0ZVSj8Q2WAIsZzFMIJCwuaeiHYPRJSGlqP7BIgPXgA//i5+YeMNJZ9klPRUh
 E+kVu4FwLnzFDYCiNWz78947SYCQ5GlreUYaX9mJIjzc6zehL9PJUcprK2zteWsav8JkadkXF5r
 woxGwsHmniqTiDZqV+I0YiA30wwX4h/BRzeJhW+wwm+/DPXxBMPek7VaKUpiN8KrGTbkJwzBjgP
 lyCA82T42KIddqoy8Z5IlC93wragw/i7nAo0LCrJP25hLZ+4Y34jvPIkJ2mnlD/5ai07iEwRJPN
 j5S2oXqqATpTh9su+8T0qVSinl4/PP+mv2GSVXTtc3cMdE1wbDNOP/CDitnMALfHd71+F0sPnpF
 DU5lhig4fRreG+3UOwaVuTUBxSX/e+vaksgehxzWje9YRP22wwy/BYDIBPN9eVG8LRcetESk4U6
 kWI58zi6T9b2sgLFVA==
X-Received: by 2002:a05:6830:6101:b0:81f:6e05:c1aa with SMTP id
 46e09a7af769-8204a00a585mr3909210a34.18.1790817613629; 
 Wed, 30 Sep 2026 18:20:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-821281a797dsm1681082a34.3.2026.09.30.18.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 18:20:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Pranav Sanwal <pranav.sanwal@amd.com>
Cc: git@amd.com, michal.simek@amd.com, u-boot@lists.u-boot-project.org
In-Reply-To: <20260918065425.1480266-1-pranav.sanwal@amd.com>
References: <20260918065425.1480266-1-pranav.sanwal@amd.com>
Subject: Re: [PATCH] bootm: bound-check OS id before indexing boot_os[]
Message-Id: <179081761269.570197.1395275495897743281.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 19:20:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 18 Sep 2026 12:24:18 +0530, Pranav Sanwal wrote:

> bootm_os_get_boot_func() indexed boot_os[] with the caller-supplied os
> value without a bounds check. boot_os[] is sized by the highest
> enabled CONFIG_BOOTM_* entry, but images->os.os is an untrusted uint8_t
> populated from image metadata: a legacy uImage's raw ih_os byte, or a
> FIT image's os property truncated to 255 when its name is unrecognized
> by genimg_get_os_id(). An out-of-range value reads past the array and,
> if non-NULL, is invoked as a boot_os_fn.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] bootm: bound-check OS id before indexing boot_os[]
      commit: ed28577c31d895fa766ffb71ec1c35c4b39db2a7
-- 
Tom


