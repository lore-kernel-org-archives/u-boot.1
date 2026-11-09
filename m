Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931C606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bvlf3X3D;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=cnKLzzFW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1502C40721;
	Mon,  9 Nov 2026 21:51:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZaQ0cSG4Ij1; Mon,  9 Nov 2026 21:51:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3EE9D40604
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794261110;
	b=ma4iWZXSGEK5DGCmrZXd543diVABUsehAXnhsU/KsnoQ9nhhlGzopQvR149U2jjBg1c5
	 wf+JPX1DHZhH8DZWSmy0nVBE4BF8pAWzc024zKFl3bNObcJ//VVkC7J88enGUiayr5G9U
	 STOuWfuG3tI1mgQVSCcfBzq0T6fA7CT+aQ74u0r6fdPXYU3gQr2JVf3ou1IGj0BHcVWH6
	 u4NnqueCtIIzHnU+KKLxkqdopLCz4XfDqmv+EJJ6PJiPvOkI3Vq+CXw+DAlx7b7AHpUo8
	 hlfpely5oVHYIG25xGfEhn64qi+VOrSRbzTVQO2iP5r8yzCKn7hcVtCfVygyVLexFcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794261110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TkxR3gu6iZfQLtUHfFnBxY1kKztRNie642aSyRTLwSU=;
	b=RnqH+aPe1W/KUg2Xmg60hn4nTHLYteMERmi4xcgN4AtD13aLJ2KL05zMa8eyEYxPFQX1
	 PWW9B9wxbucfoUiFiVEUfclWsqFr8QQRWM9s9Ohntux3SwHCoOx1NaVANOeMSLEIyKssa
	 aLBRiL5wUl5HqKd27mXXloUEeeUfDclB3eS6rpdCgOsKhTShjGrlyhmOv3Noh/Ah9vnLn
	 g7pHNCF+emQtvSWtaaf2s9gESo3VIK+etvkO5Xuy7XbHvcaCoODmlAX28CKT2uR+cM1gG
	 P/XW4ztFDH7T0gD9CITnZjCWjDoGHdxSSd3YCrbgLDsQ4mvf/Zv4gQe1d1UpL2cRdew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=cnKLzzFW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794261110;
	bh=TkxR3gu6iZfQLtUHfFnBxY1kKztRNie642aSyRTLwSU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bvlf3X3DttLA9huBeHnhdD20fTEXMTu61+JQNCeFq8nmVgbkfsU0Mgq+4VPdscy70
	 4m6QiBoO/z7zSZ8KK7ZWdLcVevqrr8y+9dOaOiMLjOOxMBkT4FaBclHxcsyxUOL36B
	 5lcaS0W2jKcmbEwBbjwTJGzq34nVDvLojCxdn7kinEI1+FFP8Jnu1bHRFQHqkfGL0y
	 PQwTjqrniNtejr1AQojw5wkaWqcvW5OV/oS/KK93VmKzipI8ghCrn5As3pj03TI/Zl
	 +EOctpaqWhPrLMZBTMBIgsrJ4nClnQFLxaVlAEta50J2Q0CUYvdBsRduYjDcVy8r3I
	 DgFuabdD1nlzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EE9D40604;
	Mon,  9 Nov 2026 21:51:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3187328C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2300340604
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GhLZSV0C1r60 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:51:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8CC374059A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cnKLzzFW
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8CC374059A
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:51:45 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 006d021491bc7-716d85c01f6so295546eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794261105; x=1794865905;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TkxR3gu6iZfQLtUHfFnBxY1kKztRNie642aSyRTLwSU=;
 b=cnKLzzFW+H8D0Pi+tBfG3Sk/EV5PMTSzy6jyLOKgIo6uvJlDh6mMkMmx+HVMbRMInT
 7kD3i4P/cl3+mWsghudtl49Uus44bs+XEskA2LWeSCQoji9aiwhDRc9Ko65xho+KiOPP
 13spDgddalvrsQ2nMNhTQUGev2MsaubO6xBvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794261105; x=1794865905;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TkxR3gu6iZfQLtUHfFnBxY1kKztRNie642aSyRTLwSU=;
 b=W5Xs56WdKR2ceWdMveCbw6U2mOvJRvF7CV2MxXTdARg8fNhFoBUFi6czUzr73IkeHY
 UNNgzAI6EsZ460RPmA+ZJ3XlAeftFWbV1c/LOs+CnKImKpns/HiqWOZl51yHRTp2DCpc
 G92VuH32IMmzUQzZdtnEiRa7wIHtTO3vpP1088h4DSx5qH7RqrABRqJaV6LT0/z3dfv2
 Hc3d0dKMOfV6st2iCZswKWCOhaQtLfUTP0El9YKhDhVuNtzDVJlw/9K6cE+o1J5AuIED
 VkgdenrPyyszj0gyTP0uNlKldtr73yiSjGk4OMKmKNLscwcmku7Db6tkYQjPPyzcLt1j
 vcrw==
X-Gm-Message-State: APuU4Z8ESfKZSgFDW9AwoIoRMQWu2Iyx8o0AGHhZyRn4us0pKmrtrztR
 UzeqssfV4k1FEaICOZOS5JKqoRvps8nh+HisIgBBdzmo7WZCzJ3zV2eiG7KrFJePok7QNY5nQLr
 pAjZQCdtZ6RkKuOY=
X-Gm-Gg: AYBFou2RuxvvW0iI3U42u1Vp3olS3x5i2puaBxupDn5prBpkhVJANyYK5N5Fw6Hrcte
 Qn9Dd5XWk7mc5H2YczWbKgtx+Tw5J6QYFel63DyZeiEF/+1XV88kaRC9HeyGYYgtYKT0RhegO5m
 6bq/TNaYrxtSDFsPmLg7vpaWWwWhp7+6jfElDBkng8D13UlPdsP7tVVE0xgMDpHIXoFyG11XHL0
 X/y5GbgwcErU/TXdamv8xbuyd8YK3NPx4yoyFNdwBZdWhO1SyfZ5kPHgN9gAQ9QXF4DxwSyq5Ia
 dSsRnflHt5JoCi14Gvf2EbxSuHiNSVkgl2OxZV0LNAXDwTdI0ktDbNG7iSr5lnjWlZAr1Y5IOzY
 UMjW2Dcr4ljcvpa7yW84G8jiLdebaOf+42S/c8mgGBCEOfGI22dVtsp7np8dF/Corgpe+vd7C6X
 oqBinqk74HaWTobCDsre4OTrWItoFKnahOIfnrdW/iArnKcZSUEYVvY6PYfPRSQuYEEPWU+ZsuB
 8shGjMusZxSgmISAkhft7GYUCH6gZPNNt5JQeK0sNZFxAKZu85JIbYogKdJ4UFy1AFoTaDazIRT
 jNFoIWtYLbhy7FeCRaxza+pXyY8caO8TNiU/udX8roe77sTpUuMRMGrLBhitZqGsvg8i4g0qwVp
 GtdzndDIinsZX+x5hLcdakRhurW8A4sRYSlnWFLmb9KBzuTy03IluZ8SaR4/4sAYlepucxFPa0J
 KssM/XKs9DOWBF2QKEPB/XmjneUm3HKg==
X-Received: by 2002:a05:6820:162c:b0:714:b51d:f512 with SMTP id
 006d021491bc7-718a576cd6amr290546eaf.17.1794261104889; 
 Mon, 09 Nov 2026 13:51:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae22f6b225sm251507fac.3.2026.11.09.13.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:51:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261109202333.19229-1-marek.vasut+renesas@mailbox.org>
References: <20261109202333.19229-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/main
Message-Id: <179426110324.2469268.11511442203637699078.b4-ty@konsulko.com>
Date: Mon, 09 Nov 2026 15:51:43 -0600
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
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 21:23:04 +0100, Marek Vasut wrote:

> The following changes since commit 934995f642a21ca7f35fa9aed5f061394fcba243:
> 
>   Merge tag 'u-boot-imx-main-20261107' of https://git.u-boot-project.org/u-boot/custodians/u-boot-imx (2026-11-07 12:04:01 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


