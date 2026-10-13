Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70C8CC6B1C
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 20:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEB0040666;
	Tue, 13 Oct 2026 20:19:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oq9iDwT0jpmf; Tue, 13 Oct 2026 20:19:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3553A40640
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791922783;
	b=mF+Krul2akU0TUKt16WXa6zK5MVbko/wbiqvZbF8yVfg4tiTit7MSDmPNnvv5OQnO+3G
	 RsFCbbmyw/23jpzJGWC9M2ICq/2mWoE7mcYkCmL2E2uVHA1nVYwAEDj5ZnGCWGVjxSexe
	 EmM3AOmdxOUHO58frq3+fxf9gUmcNEOztSPo5Szj21ATp5I1HeRmg+2+30xc3eMHwaDl2
	 1xnT6vkuXgqOelP9JNCG2S44Ud6jDeZVz9fIKO+dD8MkPoohFjRGcqFFv2a5nCRTD4vYI
	 D1NNRe46mbIpfmD12N76SOUjq8XWLXH48Gh135FU7/KYm1IKJxn2ww+hrrlmn5tAIeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791922783;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qcp283B4vKdDMXHTndG3cd36WUl5AvpEv9HdYbEmryY=;
	b=SXqhLLROS8a3Gi58RyAuzZzJp1oIYFLYTIa1zmHZC0B+pJuN/YR62Aea70Z+cWMLy8RH
	 KusWuhOlVufAuYEFWRcRc44ut+wNkDQ9+/CY1PMGGa7R6O1lj0ZHin6SHav4GsRJlLHIj
	 YUeA8sF580nSAxaMwc/YfKyZ/O4fOdpv74WgW9S9YHGRxn7FSfBRxqf/ANodB33ExVCow
	 sX6yvYsgzBeIDgKDB4Vh34tjpNTl3BRh+8MR0EMXUkrkYgRSbMycTg01OnkwFgxVJhFql
	 5FQPs0HNUHiMlp4/WGchhZMQepoEexth7KTVwBFN/fh/CitaTNLGiHohVBy0uWmNprA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791922783;
	bh=qcp283B4vKdDMXHTndG3cd36WUl5AvpEv9HdYbEmryY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eUkf8/qgXWbMoD5HMxbyJJPv6zSdxQ+JmwOeMpUnWEZsnSyvaNk0cUBAy0MeAB6wc
	 cHT62Le2DwnETV87+M9brFRZWTVk1ATok3XqX9gaQ9j+t/l8+J9B0Rv7mNbUPeKe0o
	 RqKMJYKPT06dN2eGzUxTNPgSFD2hs5utJJ5h/ZorxKuwqsvHlVDonN3F1BPgdPG2Wd
	 8+UjgGLw5KjcwPfVco2V98WnyhkaUjmlBHNfgCUimSuBPj88kzSsJzn5FwtpiJwxwt
	 AGQLEO9GETC3G9dsH/jVRtIXjJkgo3PZutnUdA3BcZ7ikoVO26unM3Xon/NTm5B3bl
	 xKWKwYlnAWYDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3553A40640;
	Tue, 13 Oct 2026 20:19:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AF9B75
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1960760809
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rcv6tyjQ9aCn for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 20:19:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5557A60681
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791922781;
 b=V6x28qaQdrychJBibS2mNi1K09CwUVUvRFZCdSWhjiQpXw65W7FfosSZ5F2afdSU1OHW
 EK7DcpIlvnGsIwNKPajGqO/9gIYBLo/4ZBWFi5ZfUKK/Lt3c63SpsSj+iP01qBpf3icu/
 CXE7zSknxCTVr2waqopfkoDMFK3X2Pk0JEDAWwkTILi8aBCg5NMnSsAjP4cpUZfA1EVOD
 ktnEbO2TmzpBrEwQkbOozqOXgqHcSUOpvgL+Hh0Yi47nusZ8jRto4BQ3n1tlexqzX9anB
 xlWhr81qB0+oAVJ/OOLxnhbRRMR1xoC1hbNpuP57HkyeHzLxKgxNorwshjelF8VQEfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791922781;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=qcp283B4vKdDMXHTndG3cd36WUl5AvpEv9HdYbEmryY=;
 b=dEcU3zMrqo9pK72SqRWMNBwQIjB9CUCLH4L5uRkJ9X9UqViVTxhypzPKPfAV3vLOcOAM
 ZvIFvHIWJ3N4Xo3EWW/4rIRNb2MLfEudjPuAm5ay64o18lKmMdHDfbAV5oiTgno7BcuHX
 2X2d+J9rKx9vXTbsDiDWBpo8To9sFXNG83yPFK7yLgjT9GRDDkAJn+98P7G5hARzofBtL
 9r+bWlIGpq3PG8YoYjeyyyJL3Tay2MbMcyxL8uFOTGiQaCqEpAtYZB3econBX3XdObtpV
 SgCjZC4EqrKXDFO20OTLZMPXPMnZAvvv2ZAkDCwWoHKDqWfbi7LvnQ7rAAIVIn96h+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LDsowFUP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LDsowFUP
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5557A60681
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:40 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-82478760557so185922a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791922780; x=1792527580;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qcp283B4vKdDMXHTndG3cd36WUl5AvpEv9HdYbEmryY=;
 b=LDsowFUP6N5uIcPVLHfu55gztNeGwqCodlNC+Zju8XL4QudaTFngKmJAckXi7/IpRZ
 0Ntg/f3zf0Fqfz0zUMW6lIfWvsYB985OHc/7lNeMjzSqQybptEWIiV63lLpgccBK3kKR
 wS9wP2g+iiLAo0dkoh3u3aW1DCsl0CA3hNy3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922780; x=1792527580;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qcp283B4vKdDMXHTndG3cd36WUl5AvpEv9HdYbEmryY=;
 b=gCh0feqLcE+BRBScizUWiRATi3Xk0Ia0xK/VTIllia45A+bcrRPU6wd23lYeuy818z
 G3o6WKv42vGrohsZslEMMGeDeeTnWCIm//vJMKT0Ygn7m5YfTnNvmr0D3tjxryUHZp1J
 hXCRMq9s0CiELNy32UefTWprM4Zf6WKJ5YW7fyVD2L7NlrASGfY+niGNelgob5EgAKwg
 Bj8SsLF3KBcxakOEPZSzmPe//SzngnKxUoqDz3/CGektn/OhL6tjhL21vDHM3pQnaY/l
 3LTNpHmSnURaiffn/UUDjcj8wTBIrQ6sBnHajK/zxKjD7/nCv22CXH3fF3Y7AjE37IP3
 U+xQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAxKDLj/JVxOQeQjcROlVrmAlOfhvqCd7Ji9rJwguZnITlpoJQEA2+VLIx1ulxzr9wULM+RA8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI2DCqPDIgyP5cwxKxgK5YmnJu7UEvGjJ9jUDRpeVg8gnt54SdL
 EMqE36YuDRrn5y8p6ovffAbIj5eneXMSFhyUY3itX5e8O2oNq6EHfW1gba0CdkbKUKs=
X-Gm-Gg: AYBFou3adfWWMLTlMeVWW1SdRKA7TqYbUNLnt3KiT5JP1R/U/5EpkSP3rpSLV7AX0mo
 S5zaIZtlmdb0GP/F6opjXiavLAqgdhxPoR3Tq32TmKJB81mUBSNb5xCbsf7M4/25dTQfsIuGvPb
 TlsXMd02WO4peIXcp1kJAQf8jyZYyPcX1H8QcV6Pg8Vc2qY01NxF00sTb9dec4wr0VTDoCk4hql
 L4BEa16qdK2gEj/0sLSpPndE2DtASa0nBSmPF7dnmyEKC8gWF7e+AfTtoaHUnQm0TWx8//zzqHQ
 k5C8WjjZWo9fn7w3um1s9gl6oTChGHeNkeWKaAP7aTAMX8QHunuR/p/XMiNB3xXMrqLys57f8DD
 3tllvzgQ/saXCuitLvW3bFlK9xXKLInwKUwy13oFMPyZ5kQ3L4K/VtaGgbkBh0psKYnooBiMfYE
 HlXqOSQytQOHNoEpyOFSVBRnZQdXEui73NFyeCccoX4M20A4BnoWOrXX3T+KRgp9FwdupUU3vfc
 LOr7YpG/qg4MJXVYWYbvJr+GppeSRsqxFDrqmCdQo0kZ8AIzNTiZbUgQRjgWV+OC1Y179FZqj0P
 RV53fHQ6yU4N+weGlg==
X-Received: by 2002:a05:6808:1918:b0:4e6:9390:e153 with SMTP id
 5614622812f47-50c5300fb21mr15502920b6e.24.1791922779675; 
 Tue, 13 Oct 2026 13:19:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c1c120ae6sm15016505b6e.17.2026.10.13.13.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:19:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Kyungmin Park <kmpark@infradead.org>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Weijie Gao <weijie.gao@mediatek.com>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <cover.1790626459.git.daniel@makrotopia.org>
References: <cover.1790626459.git.daniel@makrotopia.org>
Subject: Re: [PATCH 00/11] imagemap: fixes from the v1 review
Message-Id: <179192277825.4115168.11926162742431657444.b4-ty@konsulko.com>
Date: Tue, 13 Oct 2026 14:19:38 -0600
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

On Tue, 29 Sep 2026 01:04:16 +0100, Daniel Golle wrote:

> Simon Glass reviewed the v1 posting of the imagemap series
> (cover.1787272661.git.daniel@makrotopia.org) after v2 had already been
> applied, so his comments arrive against code that is now in next. This
> series carries the correctness half of them; a second series follows
> with the structural and cosmetic half.
> 
> Tested on sandbox: every commit builds, "ut imagemap" passes 13/13 and
> survives "ut -r3", and a full test.py run shows the same 11 failures and
> 20 errors as unmodified next, all of them EFI-secboot tooling, ext4 and
> config-rebuild tests unrelated to this code. Also built with
> CONFIG_IMAGEMAP=n.
> 
> [...]

Applied to u-boot/main, thanks!

[01/11] mtd: bind the block device without leaking on failure
        commit: 10eef5457b925020dde5210c4270ea5f7d983f4f
[02/11] cmd: ubi: report a failed UBI block device bind
        commit: 79ca2f85bfe6f0e02987d4ea53a57f4ab0a6e986
[03/11] cmd: ubi: unbind the block device when detaching UBI
        commit: 74ee4f18abc81342600dccbf788026e7537d7a4a
[04/11] boot: imagemap: free the reservation a replaced record owned
        commit: 0989171be0a4f7c282bd8ff86258b3dc12fcc45d
[05/11] boot: imagemap: do not resize a region the caller owns
        commit: 614e9fc19f182c221d372759020900722f9be57b
[06/11] boot: imagemap: read only the bytes an extend adds
        commit: 8e5116836a8f49d362cb220149dc559892130338
[07/11] boot: fit: unmap the load address after a storage read
        commit: 96270dfb5c7164328c56dc40d665d931f5237976
[08/11] boot: fit: keep the load message for RAM-backed images
        commit: 06d6f1705550cc21029669ed42fcce85d6c4170b
[09/11] boot: bootm: release the imagemap on every failing exit
        commit: 148c55c66c335b23cfac22d09d9d7ee091c2a50f
[10/11] test: boot: imagemap: detach UBI when the test is done
        commit: d828f37d96afcaccfe90c9a0af61f326cd407355
[11/11] test: boot: imagemap: reset driver-model state between tests
        commit: 9f938a377f6599422a93b8ef6b2f903dee43f56f
-- 
Tom


