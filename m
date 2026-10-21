Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEE606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jKBoNndg;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jbRpEG9V
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 721B5605DA;
	Wed, 21 Oct 2026 13:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aSf7og_x7w0u; Wed, 21 Oct 2026 13:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B333C6082B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588436;
	b=QjXel/cxHXBdPJCPyx8vHHqqvgSDlymrKXKSag+EFG5AfmVzl+0NevLYU0oyjSXfLGNR
	 ETABuAF6mrLRzxwr0yj1vhqHLtJgzPuB9fAgrlVPmZh4syCN9qKwWZN3e7Sjh18F1U9Kr
	 3UemWqmkVpXz/LdDc2UxqCAC5IVCvn1garcRj49Yh9Uy5+INb9jxv2JFw+pQNy28NshX5
	 T8v2xOPc8UGasc/A6XOZJCwTkaQDTTRLO0q0zfmeMBiyIo1Btt3iyNIlot/6CcSYSRz/3
	 cbPbx7NMyaA4W40wOW4oudayiWZhk6PKTC0xA9PxRRQmY1rt1M8YF6ihHZx/2atRmVw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588436;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pXNz5o/hskAXQoEn4DM0rFOLFw4+6fKaWRE8LZvc2sM=;
	b=RKjZRZ6wsWnc1razvZWsk0wNFy7i0Z7k01Jebcu+LZfMxRckKuPKT6m20NSxpsb62E/g
	 y5DehjIDF3RczZCeDlYr5OxjtLHJlUDaXfs1E44AR8p1C9m0QdTG9SzfW8mHw4weEnPgQ
	 MvuyHCez1n+bHSwmprPuxnrYcdmM+dtbQJ3ucHSYp1IhToSuw7A08ul29eHEXVj8UesGN
	 casFIWv+h4PFTYW35cx5qwqwd8ZAAMFSCYLhRR7KA7S5jgIx0vMd5hG7tZZKo9jFxHe4q
	 40v3RIl3jO3iRSvhsAp/xzFfynnpgkUbZNJXxDB+ot/fkvpef9W5DaicQ7x7UdNbhcA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588436;
	bh=pXNz5o/hskAXQoEn4DM0rFOLFw4+6fKaWRE8LZvc2sM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jKBoNndgrTErOlI7gD8FQo43uluKsqbUUnUYy7QfaSZIXAyNN9h9JTPiE0zA45ZP+
	 mX2pakmifQeHoTgmTZZTBHzTL4YimHScS15HB1Et23iqMB2Ylj0QqwAWfn011riu5a
	 cUZuJmWpGFcKZfVvd/xOoJP8uPOC0DtZS/JcJ8A7Cg3Lka653BQglf8GmNyWJaAXg6
	 vL6fvPd83x0J0nuRWGwdsd9UKuZ6BdKHIh/gh8OMQjIG/bcsgLTkodDEUCby8nHDUL
	 G1N4lHzlZtJKeBUbss6dczWW5nur6fNhuThRWCr21rPlUM7S4TqDmBahfKmnpBVgmR
	 2EZG+THwlGPLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B333C6082B;
	Wed, 21 Oct 2026 13:13:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 32F5723A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24F46403AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DNqMwv8RPkXj for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:13:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6AC8C403A6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588434;
 b=Oh27n4HDLOw/IooHUoLjDr/e7woFDGPYMI1c0s4cnQshYyvq0iruE3QHddcLSFbbJA1T
 m5Hm5LNVJyuY8cJyO0SekyXiGg9ROg2Gt8YjDJp+C/qyd6Rw+JlHcQPQ3V/APVzOYLOM8
 x2bw6CLr2VB2yC/Rgo6ohtIJ/g6pGsnAfn4ISZ4SoEpIdtnQHJFfaTLEHusELtCw25KYL
 tXkZyrViT94TuNwDz4MU8xhOAoj+rkj1ayl/jqoscrqMozlHSKiTkX9062obENpT5eby/
 5mxTVmlF5RL7JOMZDFkpfyuWbwxRZZBb03SJAOkrsbySJiOLyhhILDeabwWI4k8HkPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588434;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=pXNz5o/hskAXQoEn4DM0rFOLFw4+6fKaWRE8LZvc2sM=;
 b=qfZ51qBGCHQlZbz66Cp6Q9XEwjr9ftckLPFw3t+aL9VyCNd39UDr4hVvviAwFzb4CdbM
 XUU0An4jxE6hKFHDKsjodZiwO5Sn6fKVgmKmYwOc/7osgWsquT1v8EH6WGhjZNBlMsncw
 bOhjy8EWNWK+ppXGd5hrYGFdwpp2xIJ84O2i/D+b0zPUReDeEPXUWmlBn9dki3pbVLu74
 B241ltLHZ56FBfyG1XxgYTJPon9JATrA4Fd/OZge7Njbh5N6t0tRXAHp77JKO3Q6MohNq
 3da9RPq3TpiIPhO1M+6Xpyc4lFjioZ93LUsB7Brlq1qb4UHN2xkuEbK1imFLoo+rnIQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jbRpEG9V; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=jbRpEG9V
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6AC8C403A6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:53 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e9eb579c0eso4021975ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588433; cv=none;
 d=google.com; s=arc-20260327;
 b=o3hVcOmfNE7X3Ic2JZH6A6ZZaJxreTP88vhgRR3U29gu7rVCH0V4M4ndDoxPMBAW16
 JiJsT3cuJUkKxgnQ7trfNb7Um6YKM5s94aGOHaR14ssu3JnonrYLYrRdH/dC6OLUSE1c
 fkoZz7I3D/YeWa3UoWPShRt1d4TAqlDyDMyrRDXyg1pXs2rojCKFcuAiqxS7J9EkjXrX
 bn0H3rACeRD7UQ7hI/wovA2keCUTzHcwMzftMZb94m6pLEYqyf5Tv1v7X8C85fc0jaRj
 BZqJMKEm8gPnm4jNtjd2T7P7+gqE2IpAP/S/XIEiDYL82UAS6Sn6eEbWC5eMBbHLo365
 nE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=pXNz5o/hskAXQoEn4DM0rFOLFw4+6fKaWRE8LZvc2sM=;
 fh=lFEvJiD09eFkjC0zjxFrJW8v5KPieVD3ZcMao2sBQCU=;
 b=F6qn34ZV8tfIHCKWFV/V3D3H98Cw7JOJ1OhpeC8iZXYPq2koIV6iU5MedhKTCjolJr
 QHf2gvmXFU/fFPh8jM2CLtmH5Ml70RDwNKAVfgGu27zP6sYgi6PXjD2POAEeETynrHBi
 lUHPgt/c2gyl6nm5CyMWkNWtUOZlpcs+6n27tjKw2A6xBOlnHlsdhK3OGDBxL1Pqy9af
 6xupLiDrSaPoCfVAytvduWpyr/P2MrazK3An8GzxPxzfSufbamxoNtLImPve1qhOJDTd
 xxXldO50mbwH04+NRaIr/JsGxrN8icqBWG2f8kVoOjwWfVwG6YsxswNonyvSAfo2cjkd
 2VSQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588433; x=1793193233;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pXNz5o/hskAXQoEn4DM0rFOLFw4+6fKaWRE8LZvc2sM=;
 b=jbRpEG9VNyo/hLiWa0dNBwR5P16kuu/2Xm4poF+kd+mNXk7HXsPKDK3E1UiP+zgEjm
 8OB5K26Dk17tBXlvPTukpukd/AEpwEle+j3jK+rRYtpGJXDBrFPT/DuufdgxSeHbyJbA
 TQIcjvhgrRsf3um2GFuVyWw97ZejqSG1hQfaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588433; x=1793193233;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pXNz5o/hskAXQoEn4DM0rFOLFw4+6fKaWRE8LZvc2sM=;
 b=bTDRjuBLGVI807PzakE5/EoDlNRzIDwZCEwaBU0pWo540PS2h0tai0B0GlNdlmR4XA
 JSf4RMyoPBqs/7TM2Gyy1PXwQCbjMwiRZM5KdF2T9Fy2n6q6wA+aTInKjDDaP9EYKx1N
 p/2kBAoy5QJriPD4m0P+CYmvbeZHwN0PcOPDml3cNQoo1MlFrjucStkGdEhfRsJoGc8U
 LhodlmXnZJmvIM6i1mQoPRHBuMYjrx35KJzrPbtow6Uo9qdljqFvic88MdP2z/wBkKLX
 TwbTIBi7C+VomLXw1JAm9OpYu6bHEeDouMZgfz3Xnf3XuLtKjnaxeM+5LoTVIGtbk4zL
 fCpQ==
X-Gm-Message-State: AFq9FYJHp75d56enBjVlCrZ7U8NVS63WbSgoRQGO9eOd0aRbOTng1hOr
 0hzKL2RoY18PWRJP8ALSknTOpIyvjFET8e6WQYsiK1G7ouQVVA0o16uE3rg723FbWD4YWCILdoK
 ReR5fnoYVtG0/bP3ncjWV3DkRN/C1IK2sXFe9RGvA
X-Gm-Gg: AYBFou3BDTR7C3tCpf/TkzO0gUaDM1ZMT84HhBRrXVb+VaUuFMKbKagpkGR+DypuKEq
 hM0gUi4DkrafAmzR2LZczTZfokvgS/3bZxXiGOFDJF3b6VehAWDXGAQe5/z9oPwS0LWktiLRERQ
 h0Vl3vItFyUIWS/0yet/QlKn+NQbSg/AbgdB/JKe9dUYP3SB/MwfyWIHzbwQ61usuxUYU4obYOM
 r4ESDozi5h7GRj6azgTSnlCo5pKEtSF8StooF3Qgoqi1GXiNmsrQtlScTRlIGbdyW3g3T/vTTjs
 YKp3DutBSHIjGhr/R70SXC1hsbTZ5U42O8PUxuIQxrMPRTyWqcfNohlBohqCKEb/9a0JvDpJ9fC
 PGUvB6mF3wteuZ5TLwEodXPz0cJQ3LAUZg38=
X-Received: by 2002:a17:903:2405:b0:2e2:cebe:d811 with SMTP id
 d9443c01a7336-2ea43fe0efemr15015585ad.46.1792588433183; Wed, 21 Oct 2026
 06:13:53 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 08:13:49 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:42:14 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261012101054.2104707-2-lorenz@sigma-star.at>
References: <20261012101054.2104707-1-lorenz@sigma-star.at>
 <20261012101054.2104707-2-lorenz@sigma-star.at>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 08:13:49 -0500
X-Gm-Features: AclHuK_3iDedRTMrmpcXkSu1Mqut1hzdB0LMbhUpYV9PXQvAuy3EaPSTRXTw-aA
Message-ID: <CAFLszTiPL2PyeUZOc0mqZxpmYd6V1TJAJC2cEbZLHnoAw-vv2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] binman: pre-load: Move signing into its own
 function
To: lorenz@sigma-star.at
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, upstream+uboot@sigma-star.at
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-12T10:10:51, Lorenz Kofler <lorenz@sigma-star.at> wrote:
> binman: pre-load: Move signing into its own function
>
> _CreateHeader() signs twice, once for the image and once for the first
> header, with the same key and padding. Move the signing into a _sign()
> helper rather than repeating it.
>
> This is a preparation for signing with an OpenSSL engine, which needs a
> second implementation of _sign().
>
> Adjust testPreLoadInvalidKey() test to verify that signing is never
> attempted for a key with the wrong size.
>
> Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
>
>  tools/binman/etype/pre_load.py | 49 ++++++++++++++++++++++++++----------------
>  tools/binman/ftest.py          | 12 ++++++++---
>  2 files changed, 39 insertions(+), 22 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
