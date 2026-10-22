Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35A60A261C
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jrVPrf9G;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=C9hwnvoB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61EAF81429;
	Thu, 22 Oct 2026 18:36:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DEzvzbI51j_5; Thu, 22 Oct 2026 18:36:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D7A781211
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792694215;
	b=XUW9QG5iWvfukVIF9eTQyE0Vg79bIkg6RYcqxQB7zOJjlaRLjbH8FyqiuRnW3q7sD+Zc
	 Owapi1nT8aLv4p5fob48ULIKTmGqAhYEcD4Yu/RBkAcw0OL+piRtxa3BlOsXU1MNrUFrr
	 hYCiVaXOuUfjFcX1gNRNfeOXbgYEp6TGxa1ydU0aOvOJHN1OEXx4PsMWRUZomsPem7TkO
	 WhDtn9K1gbNni9rP7CbnKqPgBLRk2ExAGsQlioblGZhXGSYXYhaRpNEYkM9RwBZVDmNVG
	 BV4WljoVjVo1QDvfhJKt44jIZmgjbhPxKOXosiXl9wvwWFW32e6gOkjawIpgU8yJbjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792694215;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aBjktMowNSuvh8iXZSRBL5YHH6QaUh/9SyZJ2w/9wWo=;
	b=ltOppa8B9ePI4ozfN2LVsKChBvizMF1lJb2RIeAa/NJTWlWNEkUT02lMkoIqZYkVgcJq
	 1yxJsAQiomeczvIHOfquYa/1O3qb+EnjtrsJzDqjOn4lYm8LlhBRBE8e0pUevVW2op2ii
	 FozOdgnJf3QQGlwfhdFrVEa5Y++u6Rt+hywu/EPeltq5lCbWjoAV9Kvj+o8+kNwaE/y8U
	 qZQorPTaduBgoOKluumB0j5VEMlt3IW6SqGlbLcZSnGQ9yK4U8xNttWj9Kbzj72f1fxIE
	 wSnYRvjvBiqUW+1htLli3Ipg07HRlfhy+SE2Hpri1pKVbuhCliXNPQr1r+5W0hZXQVA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792694215;
	bh=aBjktMowNSuvh8iXZSRBL5YHH6QaUh/9SyZJ2w/9wWo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jrVPrf9GufW9J3nApBLoRbfB4OGAzSFvEXL8wPnT167p4yKvS1T1X6p+DXaZS36EW
	 j5Vt6mniuRaIsW93mZpFhG4vIxXw5vNBsy0tn8RYU6p41SSWfqllLAvCLzdH5eWvdI
	 5+Gj4oEbWYyLMiZB9UVcjdbmKZv/BKqeHk0ujhK9cDS0ssivGrRuba+TG0PSNcKm6T
	 NEjnwOq2VY/RfZxP9hWrDBANt375XIpKIGUF2rKwiHrv/XZ4Qmw8oME3qFrqQLt6e5
	 x2YiKKeSOp1UQIOuYfY4xQSfIISMUgBZHJSz3OTkCdOKdrPaD8VT89qZ5jJTctGPjM
	 kLySHY2Qb6xYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D7A781211;
	Thu, 22 Oct 2026 18:36:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E553D3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D714D4080C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBbByHOPwMRr for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 18:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE9C040979
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792694213;
 b=ckfI7b8tb1RFZACL2JYVQtabPWsv7lyiWXEj8QAgUSRVEXZBOtb9Jj7cllyVT38QCaxd
 2kNGLpH0sw8cNyCRENkTAfohCSeLMnj1satW4LVGZ7j1otSL2u0eVucqmkae4NIPu5XJ+
 bVhWfuI10qXWfclCkW0OxGyKjdElLiSLorwTF8wadzVekkag5Dd8DqNM5HE1wTPsxGrsw
 wdz6c3SO8ypNfCSmBy95zpXrzjKptRGIGqc9L2nhcruLavlly/MN37Ogcuc04ZDbxAuk1
 cKe/Zw0eEnXFHtRpPvfR/d0vhLhXakKeH0igGRfPEE3vcd0xhzyBh508I4KgKw7LWfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792694213;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=aBjktMowNSuvh8iXZSRBL5YHH6QaUh/9SyZJ2w/9wWo=;
 b=IL+nzeKxTUX+StmELchT3gRvGF3IyN4DLye9tA0vBbezVhS/Q89bY7ZQuYlvIT6hM7i4
 Yt4k78CFnkDlhSoWXaMFsAEkHR2vmcVl7Rqpdj4qcTh7s6eG9OcQLGSB7vLC6WA2PKExY
 Ci/h2sME7jS10ZHeHjCwSdNcAbGQoOn0oc0ys06G6Z/6lM/TZLVs9oQZ/4uNsIcpM1wkf
 4/grWRqNUinsxWjeZkePnJdpXYMZUYLl0pxjG+qLyI+t64A+jJvYbgIH+eTXez7kY21Q/
 hw3Y4OoE9qpoa4v7qR94PhHj7g8qNfC3UYmq0hhJZUPu6ntyjVXurBTUO13JyocXQtw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=C9hwnvoB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::2;
 helo=mail-oo2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=C9hwnvoB
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE9C040979
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 18:36:52 +0000 (UTC)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824413e10dcso14585a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792694211; x=1793299011;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aBjktMowNSuvh8iXZSRBL5YHH6QaUh/9SyZJ2w/9wWo=;
 b=C9hwnvoB3Ck4qkjPQXplcEXFrcSRrs+sJagZC9P8nYhl8tbRZ3siT1b75i01tz+4YC
 LmJ7eYo7bF1Gn/+0Ay+l98ycUxxAEszyORW0yKM8rH1MltfrGiAnn8HkfxvFTpPleaEN
 5XswXCAORteH4fjGdSACXX7deDTg5k6vSswng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792694211; x=1793299011;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aBjktMowNSuvh8iXZSRBL5YHH6QaUh/9SyZJ2w/9wWo=;
 b=WuCtc0NWlGxPpgJo1bRjoPE/KheLgIw9FkY+wx6fcazduCUFB2JRWhIP7EVPIKJsAF
 /5KlSqR7pzunSt4tKiyfp1jon14IBzL7YbWmtdM6+/NlhPEhGv8OpByoWxFopQjBQvJ6
 IcPV0ccX5nvPvwDg7MKEj+88Y9BKfTbNis/I8ol2tY3+wFwrbFxZTOGFZhWQbUwbcw41
 z2lvMZchU55KEo0Pyj7asZmgkD0nevHFxLV+SXHuYh6tHliKnHywKydQEoxTeAB6DjVr
 n4JdBH5LoGhytc+N5S4Mu1hj+Wy1Rm2CTaV4unyelMQiUZc1khWXh9lslW8WjaBBYMhH
 KKpg==
X-Gm-Message-State: AFq9FYK2yCBUlJ7+GYOMFw7NS1vV00uLiACGrJuehMU8NMTo314VgsC9
 3uyb/i/rVWKOJvu9R2os1YGrgCP79Q/pMam+9p5bBdef1VTK0s29v8suQxDy7s6VWzg=
X-Gm-Gg: AYBFou1uczOxvTvKshj323qHCDaOarK7xDjyc/AN7IxD4AKnlRC5+78+NqNyEHiGmzY
 u1b6N6s/6g4wWM8aIhKZjssjJlR9WokUl6rlhu4FyYfAjmPKMbzXYQVlrcfidiEUu2t0SOe7zW7
 0I0oiGtJ5yaujFS17T1PE4RV7SShKrNKR2wW0gKwDDYRmgSi+v6iNH8HhdQv4jWCXWQyzzVeWP6
 YJI63oj9vvzBqs2zFE5IqhD8ph94G1jd/cQEq8DuhfwnZK5EUMxW6p81W3vmwNuYiUi1c8qn/dE
 0CfXia8+Yj9IRGSAOuhE+fbBIRxwHq2ewY8qBnccujZI5jAQareWt4EM69waxfYkAScED6ztDpt
 l4ctTTkH5XHP8RxGGBTi7kEyWcD0pLreUeQnf4pMSxYxYv1mqdQtEJRryHl1SKKuUXAbKl/8Jxa
 1m0vU5Cri9l8i5Nt8ijdeh1RBSCaxxcJR7XwSVPxz7Yd3vaO/ynBI5ningZ2DlKTtXgAyPT4LZg
 FaKAoz64afkkW172g2VfK1mZtEVZywCae1igu03/6NJd6z2L4UsQhGLKGA5yz9quV6jJmelflR6
 dEa3P/r2lKP5A8pPS8z7dmt9ryFKy1Rn3WnO5IQmh16T9cDw8pgOoJzH5dOtDLi5tk8+aVPWiDo
 =
X-Received: by 2002:a05:6830:440e:b0:805:8b7d:d8d7 with SMTP id
 46e09a7af769-84d0810aff2mr4809659a34.7.1792694211669; 
 Thu, 22 Oct 2026 11:36:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84f784f3c50sm437028a34.21.2026.10.22.11.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 11:36:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, nd@arm.com
In-Reply-To: <76cccf4e-e4d7-453e-a336-46486f708303@arm.com>
References: <76cccf4e-e4d7-453e-a336-46486f708303@arm.com>
Subject: Re: Please pull net-20261022
Message-Id: <179269421096.3644272.12264201612618890293.b4-ty@konsulko.com>
Date: Thu, 22 Oct 2026 12:36:50 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 13:49:04 +0200, Jerome Forissier wrote:

> The following changes since commit 62c9805d8d57cad407f0295879cc9a6182da464a:
> 
>   Merge patch series "fit: use constants for the cipher property names" (2026-10-20 11:13:13 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net tags/net-20261022
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


