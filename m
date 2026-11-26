Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E1606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=teyikcov;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QBpV8FEG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6ABF608BD;
	Thu, 26 Nov 2026 07:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tflyo2ZO1p95; Thu, 26 Nov 2026 07:14:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D665E60671
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795677250;
	b=rdu7fCiY9rytcwGiZmXYxusWOO2+oLqhyovsHmOImO0IyMS4INb1+tnSX6UqlXWPnR+o
	 iZDnotwh6K4ohdQ4B4WFUSL9J1kN5oIeNAi1IeiJPJhQRsc3I91v6fJ2D1SWZnxBnQdDm
	 ClTxyNRBK2pCcJP+bCh2gpISiEbrll4XzIbiiNU8alw0mynA3ZKtD6HmVOw7HJRGKajwq
	 uivr5QOxCZxR5w54u25HNNw+FQea8yBXHCDr1ZjVzkYYhzsGsWJUIfzntuEdsh0N3R898
	 d42jx8XddxOXW9VFHs3khZkzngNvVYeQO3Yqw2J6yq4fHQJ5nbL8br4Iw/F+tKKTSdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795677250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vBn3+hE59msHNRJSUh+EZb4Ly7oLIpA4/Fsw+RYseO4=;
	b=oWFE0WU2JS7WaELjY1IecV91sv9R28kIKVdCUcVvw/32dGhGxR1cnLMEL5zbP3LXffkH
	 WswsZC+IBzgvzGFcf4eHT3QI9+BAYhFfbh14+wj2DdTFaMFjDXzD4OMd0zHJzf0wf5uwR
	 3U5ITQmdXuzzxPzomMHzn1/+zCr3tzG40bIpAy4H/gLPjbxRdLzwhQ5q3FlpGWA8hKsUU
	 QFZu49tkTjOya3tModfd0xOk44JyHLthXJvxCD6A5rWsbXA6YQlls+UKCagmjDmvdOMpt
	 Y6YCniJH5itN7P9DrBT5SCfw4QfcWyBDIpkG1z+u6Syucc0omC+ibRmrO7ZwjZ/Aajw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795677250;
	bh=vBn3+hE59msHNRJSUh+EZb4Ly7oLIpA4/Fsw+RYseO4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=teyikcovDbnnX2t5rjdaNTQ6sONub3fy8xXrmRDNCjkDFaUrEEmHdXHdYyCJ8ZBTW
	 GUCXlVVRWm2Qe81uK1fHArt3UGmGcumTwhoLu4hBoF33+bI3oA6sSY1takDiGl3cSM
	 FeIf0KOsdCWuB4OTy8iG9R7NfwJUEvEjF60bn0e9zXsejb4pLkJ/KQgyKk7ceNpGgl
	 gCm09E6O/4HrTF+nWDPGY6V69+dRu/kz/o/2DxBLHMhTWD1vIRwK0e7AR1ccThmKAe
	 cWlZnkGo1R4LMSSUn+MC75gpXLRhzY+u/e0htaXrErJGzZC5Z27GJ8MVQfoTmHRVxx
	 qHomF8mv+Owxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D665E60671;
	Thu, 26 Nov 2026 07:14:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8803D22B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7973D80CA6
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J3en3HrJY606 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:14:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F3F280C46
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=QBpV8FEG
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F3F280C46
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:14:06 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4a32576da88so3782651f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795677244; x=1796282044;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vBn3+hE59msHNRJSUh+EZb4Ly7oLIpA4/Fsw+RYseO4=;
 b=QBpV8FEGFBLsFYMpQHyt8qJ3FmSkdlmIEugozE6iHtre2xnnzB4ftbQg2KSLo6QbV9
 uGlXh+DYIeEl7KwraMqSPlMOd0bTrwJyKVH93YaIwrbOQ2IoJkoOXOmIrLJfv1Bu8xIl
 L/x7OQweMJhSO/UY3AAFsdzaeFztvi5+kF913S/JxXxKXDA2sNH9bRgsLlEUyHqR86wW
 fKoLTJLPyzgj6yCfpSINfQ8U2fnfSBA3XhBXVb3QuuWGvURYWlfOM/UbhhcTleGmlPrd
 MAnApqDGmFkTrgJncC9Ee14/yGwC5yFhm5cBV1kMplvAfCRqiWBK5bE818r1r9WSmrl/
 IzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795677244; x=1796282044;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vBn3+hE59msHNRJSUh+EZb4Ly7oLIpA4/Fsw+RYseO4=;
 b=Xg7lz+0ei1/V72dtOsHv6WjP0kYUzxPcVWg/GHDXI9OT0tXO6WtcBUMMJAMtTZfc6L
 jgGVRQhvus326r7OWJcEdUbRLZzNfecMfRB6NUGRYW5UOHrOO7BdGA2pGh78OCD8Rm74
 kXl/LaGvevB84/cqI2cyh+yA8JQ11w8oiMcl5cvK808ZH+ELzFSoARidQ7lIysn93Ahl
 VP7cCEp/S7Onwf5y+EoZMH5cTDX1YTkOuahx67iqjmCQ7DVhgStefzUt3opz4JJCF3IX
 CiNt82F17a17GUBvjTHUEHV7+L6L9Z/lfsSBPZi5obYvxWNWjvUzjbDftlyvA3LVl1pD
 jLtQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEVhRWVgb9YJcc51zQlx1JGy79UfQQwxgJQhpLBHn6/jriOiaSqqa6OnSbfKMdTFtTZKO6xYQ4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/WYA3ThDCAxHBIZEpYNul17q2hCnOVwmgOclVQXmYQkGNeKJ3b
 2ANLdNB1oLCGkM8X98SndYOCiDXU9ugJSVwNtG6GlbDz8ES5FCveaOgInA4ZY9/blj0=
X-Gm-Gg: AZFdTZdPPvLRNsE6vi6HPaBwysI00JwOCQu7CRkD8p0K+le2EQUgGYt79x1aEfxScsM
 1wPyXD5ElKfG4oXuuGzSWm+c6hSYIcg6JgE3hL3M7Ss2O1Y/a5jL3aM2260PhV5T5FFGjP9GleZ
 usrH+lglhPqnFh/vgO5Q9y22KwanqggaTXEu34LTd2P4HaaOSiucwOqvSCTKjzqyIps3Ug2rIvp
 QZY25WDMyaHl9j+cL8fF/Bm7Y5YCug9TPBoxIzA2GPufVYUKOBr8ZC/vFsvib0Chx1pD8hF7cL7
 vP3TxHSHBDzSGSu6NnGQdajhr1ojorQt/PbXb9zt6I1dgjQj4cxr2JVlvWStcArTHgNIIQmEHL5
 4r4nHXfaf5/khg/fOPTtTD+/eLjfiVfYXCW2vSaQQZpu0P/uj2ceO1gTejJqOM0pjTENRmCuIAw
 Qg4e6jtJk5/cSkuGJ8GFebGu3pQmSzXCdrJf2JZKLXRFJnaywWnvKNLBOjlUisePOQLPZCcfK3B
 iptZUP1B9Z8mwcTR8XCtVE6s+XgFhS9CCyXKo3Z6h9GmGzPlK694j62VHxIj+8t8ae9qza9VCND
 RVbIbnIwvwxdv5U4rkdFs4E9zU34963rCYC/XgnOM/nCrBk3r84BN/9SHj73n4isCOO9is0qSQr
 E66RHf4UwopvPsRba0JwEjpMUhoVcnMpfnwN5mOdY4AiV6OYn2ralvuEls8nHjWCw6Idq48jnRq
 1vdIuu8AVw+GJOdQkMYB+u47mbdzaAmlRLTTT7UyceJ/pHbvYKvw5/4arN0MbUEwtaBzQ1PeBgQ
 KqC2gxh7rCFMLQeGMFskiWU6iPdvztoV1H2f6VkCIuSE781yyQ3AfckorIPwKicP7pzWpmv+jXY
 JP20hr1tRCL8xUiQGFbIq5oFwGdXx9GjXo+Z3nzWAdAEGYzGZ1OztjA3EM8Dm2LqFMcyEPMsGQ9
 zNqxl+wdJCKB6SUF/YxNmjg7L92orr8g2sZTIWPgOFne8jtVHOlyoFYlYxUFL8V+xzDRwiV/SWA
 h+L+/9/oj8/lhh5dw=
X-Received: by 2002:a05:6000:4312:b0:4a7:2673:ad2e with SMTP id
 ffacd0b85a97d-4abacfea57emr41241545f8f.1.1795677244493; 
 Wed, 25 Nov 2026 23:14:04 -0800 (PST)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm44545289f8f.24.2026.11.25.23.14.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 23:14:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 09:14:02 +0200
Message-Id: <DN4YGH7ATHND.2D2A1BHX2WWOR@linaro.org>
Cc: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH v2 0/7] efi_loader: capsule: check sizes against the
 capsule
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Ana Bobillo" <anabobillo3@gmail.com>, <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0
References: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
In-Reply-To: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

This doesn't seem to apply anymore. Can you please rebase and send a v3?

Thanks
/Ilias
On Wed Oct 28, 2026 at 7:49 AM EET, Ana Bobillo wrote:
> The capsule update code takes several lengths and offsets from a capsule
> and uses them without checking them against the size of the capsule. On
> the capsule on disk path this happens before the image is authenticated,
> so a capsule file in \EFI\UpdateCapsule on the ESP makes U-Boot read
> outside the capsule buffer the next time capsule on disk runs, even
> where CONFIG_EFI_CAPSULE_AUTHENTICATE rejects the capsule afterwards.
>
> Patches 1-4 check the capsule file size, the capsule header size, the
> FMP capsule layout (header, item offset list, item offsets, image and
> vendor code sizes) and the certificate length of an image, each against
> the size of the capsule. Patch 5 checks the FMP payload header size;
> with CONFIG_EFI_CAPSULE_AUTHENTICATE that header is part of the signed
> image, so there it is hardening.
>
> Patch 6 adds unit tests for patches 2-4, and patch 7 capsule on disk
> tests for patches 1 and 5. Each test fails without the patch it covers,
> except the one for patch 1: a capsule file shorter than its header is
> usually rejected anyway, because the read past the end of its buffer
> picks up heap data. Valgrind (CONFIG_VALGRIND) reports that read without
> patch 1 and nothing with it. The FWU accept capsule check of patch 2 has
> no test, as no sandbox configuration enables FWU_MULTI_BANK_UPDATE.
>
> On an MbedTLS build a malformed certificate of valid length still
> crashes sandbox in efi_signature_verify(), with or without this series:
> pkcs7_parse_message() returns ERR_PTR() of an MbedTLS error code, which
> IS_ERR() does not catch. Vsevolod Kozlov's "lib/mbedtls: Do not use
> ERR_PTR with mbedTLS error values" fixes that.
>
> CI: Azure build 13698 passed, all 91 jobs, with this series on
> https://github.com/u-boot/u-boot/pull/1064, a CI-only pull request that
> also carries my USB Ethernet rx, ext4 v2 and block size v2 series,
> merged with main c267fa81d42:
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D13698
>
> Changes in v2:
> - Use size_t for item and item_count in patch 3 (Heinrich)
> - Test a capsule header running past the end of the capsule in patch 6
> - Add patch 7, capsule on disk tests for patches 1 and 5 (Heinrich)
> - Add Ilias's Reviewed-by to patch 1
> - Rebase on main
>
> Ana Bobillo (7):
>   efi_loader: capsule: check the size of a capsule file
>   efi_loader: capsule: check the capsule header size
>   efi_loader: capsule: check the FMP capsule against its size
>   efi_loader: capsule: check the certificate length of an image
>   efi_loader: firmware: check the FMP payload header size
>   test: lib: add tests for the capsule size checks
>   test: py: efi_capsule: test truncated capsules and FMP payload headers
>
>  arch/sandbox/dts/sandbox_capsule.dtsi         |  52 +++++
>  lib/efi_loader/efi_capsule.c                  |  64 ++++--
>  lib/efi_loader/efi_firmware.c                 |  20 +-
>  test/lib/Makefile                             |   1 +
>  test/lib/efi_capsule.c                        | 212 ++++++++++++++++++
>  .../test_capsule_firmware_raw.py              |  34 +++
>  .../test_capsule_firmware_signed_raw.py       |  56 +++++
>  7 files changed, 420 insertions(+), 19 deletions(-)
>  create mode 100644 test/lib/efi_capsule.c
>
>
> base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27

