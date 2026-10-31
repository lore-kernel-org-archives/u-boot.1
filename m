Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DC606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CLT4H2rY;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NJA/Zowc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54981810DD;
	Sat, 31 Oct 2026 14:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4woqyOneUIF0; Sat, 31 Oct 2026 14:06:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A0EBD810D1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455585;
	b=VRy8qRzc6p6E+wAKZ9OSA0sHQuHjCwscgZbHbgZQLvWLEbgvlIJQidrYWKxtrhgtl58O
	 LdFVv6FBGXte+R8oqEzMxXN0cM8yPVtkJySU3QSmKZSJz5mFNqgCYOZ/0kSakNOama+1F
	 BaaZCcAJANY//B2YUPRK5ZGmz9/I+rEQ9KLSgdRXUfUatNTTvLtrqUmh1UMYPUrwQvWlU
	 lenRSdsmB1JssOTeyKS55UvOzmJ+riOdYwUKqiADDOJOCvROsaD9J7/GSFi18u7k+kXci
	 4yAj2WBfYHHXBOI55SQmFiLjU47EL0d3SqZt0txeYNjnd2eZskw4O3P1jDcYiS4lRcw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XUUA2H4HtTd1VlAtW66qn2BKnI1l2F1U3eLLpLxAM2A=;
	b=asK8yDJ1+W0dRvq47szXFE/jYRj1mdusCp80cqZsjSRWm/Zv93x1Y4a+1nn0W+ilJpRF
	 7n6ixVhdjL0Y3s77OYaOnrcpVmWvVT6RTG0no6uzVU9tV3n3QQbWdFqONAMxwkf605GXS
	 rE3Sw2nIBWOWjFsCXjerKIk+DQw4rN60qp/0C/+vI6zNylYGoLFOLzqMaEfW+yZuKlyhB
	 qf5akz8b4ODhhA1TtPGi2S0BYOnJKSVfeNPDs94YVGpMdHdWfmhHCjBdYcvfM1VZ0m4DV
	 93LRiM0ztJKKNtnnyS63okFkSvXItxmIyUYcnlJh4Nv927N7rLlPiDlG5E3n0uv5lrQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455585;
	bh=XUUA2H4HtTd1VlAtW66qn2BKnI1l2F1U3eLLpLxAM2A=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CLT4H2rYqR4BdBcKDPgamEaPTSBvuRPxPZwP5C6hHosj437yrmXgnaarEA51E5lVv
	 5RhL1cHTnSAB1GFq2RqCKdaThVik1uYrlcvdM6UFW5kkVCem3wQSPnYALIDtTRWGMn
	 ojkncYvHtzT03VqiMgauPmFdNh9dFq0592NrhezySyNOqBOYmO0tXKynMpBXfXRIHV
	 TsrDppV3nFWyPh+lRDG8TIvPt9l5nEJs6DoORRqQlw70GheVNcx+Kwpsbf6LnMQHST
	 7iFjoTCbHKdmjFoMXWxsuqmI2nOzNsMoaWRbOaaOdbFeHhsnSpI+8f7jU3UtLCKzQE
	 osnXcx9N7MfNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0EBD810D1;
	Sat, 31 Oct 2026 14:06:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 10382411
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA4C14008E
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wpoc9WS3lF81 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:06:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D8B8D40049
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455581;
 b=A3pAcumS02LpPoJFhy3GtI11UccFN8H8sLIgaxkOc0Aka5bt51Ulb/Fn9JIDWprRr1eX
 +aueihp+TfB0qgiRUOP41hZ6s0IvGofj8TWtsMKpBUA7kGWmXls5GL+QVM3AHgC5jL+zQ
 08J23qLwfytJ6KVvEOoq9rRBtAwijHp4F3IB/06fZr3qjw3OxBtzH4HRC5TxOhaqA6F/G
 UTlLPDPHvQDtCXyP3JVb2TrrNZ5/A0FohupliFxBvPQNxs9HnVbjfFadvPoIwn2qof6SV
 aYRNo4nguqsCjMTMeH+aw6XBIoE42R7AtwmuE63vXcJrOKSflryzYXbf3X1sM4TDb8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455581;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XUUA2H4HtTd1VlAtW66qn2BKnI1l2F1U3eLLpLxAM2A=;
 b=czHZs5f31wj6IqhnfMalaRlg+i5+J95U1myyxP3t/Do+Gei7BlMqeEjM0OFvg2d3tmvD
 LVMnRTKmt2nBFZyVYBhtUu7E/32al1h0Vwye+xR7NLHoZyDWd/gAeH4+EH3SM8RyPbyJi
 LXFlKhE8eCZiPoxMC65s6TRre9Cd3gnAmO32tgSnmmF1s/mhg29QHFTEMs8f0lUGJ0BKg
 Z9COfE4PA29RG3bFmwnoFzmW/NeqHv7TjNzuuhl3LVzuAvA/cgcXGHf3boWkrYsUZgJN/
 F98j+nufnjbfOuEn0BW2cKh25ImREaznKu/1fjT61eAaG4M2BIdpA7L26CXo+cFMkeA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="NJA/Zowc"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=NJA/Zowc
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8B8D40049
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:20 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b4e814214aso1441808a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455578; cv=none;
 d=google.com; s=arc-20260327;
 b=WGSzRGxr7tw6fXPmT62xmNGccPxIxexKTVTfTDXZzUSOwctWGTGK9/gxn1iAfGQEpT
 LUWJFYXvRfCiHNIRW8rbnbkZV2RlT+dVoK+f6s0ygOn7309qu2BMemsE9uexDc0m2dAX
 mfcCQGaofno4FCV6TN9F5V1/X2D2FGmq2jGs1510gF81xhK6kuNMoKUJ5vfYaG1KMc8U
 +viUH44uhtSuOt7GV+qcwvc0Og0ZJBkLdyifJ2ooPT/cvBBPCnzpM4/EF+xuHiQFIDca
 4FpoEbhFRS5Fgkq8x37+ZaGAVv6/z9i9K3vPTs+Kz3HDEElvQxaXlzWKoFc2K5+2mWc4
 AOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=XUUA2H4HtTd1VlAtW66qn2BKnI1l2F1U3eLLpLxAM2A=;
 fh=f5wSDdcg++oko9OgNw5JpH4UTxXuWPIut09wo2oEKos=;
 b=QOgaBu6fFN76ZLhFYnVm5Mszr3H/jkxEUwvUrWM5yAOfpHVl1k7fkvboK/WAd1v6mt
 wxN3VM1mVQjhqulu1e4qgfDHM1Qwy5gHoCS46EkCGOegaKaNo4k4d86OTH0Hr4kfVpE/
 LL4v2vYMb8MwEVlsqmr458Pb6R+lRS46tMfpD7WuCrY5l4M3p0PUNFQt+d4A7Yp/Cqjk
 1adHy298neyGnRA1h5XMzqtNpftkCKSLNecL/h5SfZ35H0lDQSuGzcab5zv8nKCpucWq
 BWTMoul3rsbKIF8uUXtLW/6HJ7qXCn0vGc97mOtW0eEZ+R2RdRCdZ6Yf0kM+CGAKEdCC
 l2Pw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455578; x=1794060378;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XUUA2H4HtTd1VlAtW66qn2BKnI1l2F1U3eLLpLxAM2A=;
 b=NJA/ZowcjpWH4dd1ykRUXFX4Yd4AhxtfcBlNVouLiKeweNj/zHrTpwUEtMPhyvJxDl
 zGbKRiS6GEnf0mn5eN9CKumNiTQIFojrGNk3HnfPwytQQRpwfFDY6wrHa7sgyKlpf/Wt
 zHfsitWAXTnevMoTmJnq67DLY8584EB8OXOak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455578; x=1794060378;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XUUA2H4HtTd1VlAtW66qn2BKnI1l2F1U3eLLpLxAM2A=;
 b=fU+VDkjQoTWK6Jyh8HxTLf1P6CcClcq0Trfvvemg4V/ev0zl7JcGNv4VQS5dRGx0U6
 9Flp/sg1kZR28yg3II/haeWwh3bqfhdO8pj9ZtuFNi/WRpWw44fatRfvbMG476T+J8up
 1+HxogPbv6FfKXsuuBUUXPyWSvrQLj01jYHw7yzGIlHhtPQOovAZO57iVjEyJCsHS0yE
 uAWyzGUni87uQiauP8juBg0TJlmkvbkqvjloeQo//zBkj2j9dbwUucQMNSvtdBxU1i0B
 vBEcbxouMf4MSekJ0IDLs0gB1sxWf7stnicCoYIn5jtqnkFDSUwroaUr0i/h+4xBRpjX
 Y2Pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhiTOgdc9Frhq7/4g8HFCInEU+ulw4rW0ybwW+hLz63Jpu9Ug+ojWnoMl8ISqRD4LmVbEhvgk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJu29HA6/0B6zVxZd5kvoJHGTlSjrTLqpNPihvFEiP++iOiRRHO
 75fSXQ3X24pDaDcULNdjpc/74yrQomA2oy+6bxNS2Js7vtxicjZ9HFWYbQ7bn+Sw0cYubsT8U+u
 LMuKzEwQooHRVfUi6WD3UKF2+DdlWCaVeaYkY6CSo
X-Gm-Gg: AYBFou3Y3/fj6Dbbg9a3k7+ek47N5vcFB6/A3UI/UznrGapH+WAn64BWZu7pHJjEO07
 A8nmIB6ovatwQf2IQI5boDAw/dS1dFvitF64lZST1bsOg8Q2oUalTEDIEb6yrYX3orhl5Od92pk
 rud7E6vt4y8r88qlLHWDLw/luUlqf4hHt8Hi0ZQiDbuY6igbWk030Z5vBd5HPwzXS/4u2CTBLik
 81gbqAtiHo/0eyF1AFRIhagPoK28AR5MdDie0TTCrawCMhqmGvD8hVwf6OGXEVjuagrtSE1nV6O
 j0yupKdrFr62M/CSgDJvwxDk1dpm6iK9p/gsuzcF1McmxNjWBxt7tWAwNE9CEYAei2qpZ8ex3j3
 s9B/vJQGYs/Y2pky7qnH/Q+rR1ArUvn4H8bMC14o9d3CfRWZerrcREPY+eUYy7/Dfmp8NdCrd
X-Received: by 2002:aa7:d6cf:0:b0:6b4:16fb:b99e with SMTP id
 4fb4d7f45d1cf-6b4d4c72241mr2870532a12.33.1793455578498; Sat, 31 Oct 2026
 07:06:18 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:06:15 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:14:40 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-main-v1-9-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-9-b5a878627107@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:06:15 -0700
X-Gm-Features: AclHuK_ZAnXLGri4d5W4RyeUZQ7C54Mj3PX1AA_j8mnHA7vgLNtslGTKjUQWW9c
Message-ID: <CAFLszTgQH1PQuF56qtxi4M9DUpQjBnF1n1mLGhqKbN-dj9ogHg@mail.gmail.com>
Subject: Re: [PATCH 09/10] test: boot: Test the RAUC partition name check
To: frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frieder,

On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> test: boot: Test the RAUC partition name check
>
> Set CONFIG_BOOTMETH_RAUC_PART_NAMES on sandbox and give the
> partitions of the RAUC test image (mmc10) matching names. As only GPT
> has partition names, DiskHelper now creates the image with GPT instead
> of MBR. The existing test passes with or without the option, as the
> names match.
>
> Add a second image (mmc13) with the same layout but other names, and
> a test that the RAUC bootmeth finds no bootflow on it. The test is
> skipped if the option is empty. It needs an #ifdef, since the string
> option does not exist without BOOTMETH_RAUC and IS_ENABLED() cannot
> check a string.
>
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  arch/sandbox/dts/test.dts |  8 ++++++++
>  configs/sandbox_defconfig |  1 +
>  test/boot/bootflow.c      | 27 +++++++++++++++++++++++++++
>  test/py/tests/test_ut.py  | 26 +++++++++++++++++---------
>  4 files changed, 53 insertions(+), 9 deletions(-)

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1824,6 +1824,33 @@ static int bootflow_bls_prefix(struct unit_test_state *uts)
> +static int bootflow_rauc_part_names_check(struct unit_test_state *uts)
> +{
> +	ut_assertok(run_command("bootflow scan", 0));
> +	ut_assert_nextline("No bootflows found; try again with -l");
> +	ut_assert_console_end();

'No bootflows found' doesn't tell us much here. The test also passes
if mmc13.img is missing or empty (e.g. 'ut bootstd' run without
test_ut_dm_init_bootstd first), or if BOOT_ORDER still holds an
unknown slot: bootflow_rauc_check() leaves "A B rescue" in place if it
fails partway through, and get_slot() then fails the same way. Please
can you set BOOT_ORDER at the start and check that mmc13 really has
the expected layout, e.g. by asserting the partition names with
part_get_info() or 'part list mmc 13'? Then the only thing that can
make the scan fail is the name check.

It would also be worth checking the environment after the scan: clear
the variables first and assert afterwards that env_get() returns NULL
for them. This would show the env_set() problem I mentioned on patch
6.

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1824,6 +1824,33 @@ static int bootflow_bls_prefix(struct unit_test_state *uts)
> +/* Test that the RAUC bootmeth ignores a device with other partition names */
> +static int bootflow_rauc_part_names(struct unit_test_state *uts)

Please can you put this next to bootflow_rauc(), rather than after the
BLS tests, so the RAUC tests stay together?

Regards,
Simon
