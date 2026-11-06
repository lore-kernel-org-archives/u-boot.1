Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07D606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o0ZypCu0;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mzFSwx5Y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7223B812F1;
	Fri,  6 Nov 2026 18:06:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XlrCr3hAgAp2; Fri,  6 Nov 2026 18:06:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CCF8181331
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988418;
	b=hMVbQbjHqAnezss3HNbI+C8E/u/O+VK380pzQ05+aOjFXHAZzHfotxotKFp+9osHJiiV
	 h8SuspqcmQA5dZ3ejG8HC7OCsYVPjSdqrvu006gRa/775RNhS2LYbCeXvQmdJIvzE1K3U
	 s1g5fahmohk03t+JTI/Oz/ec2JPKAu4F/nejXk4aSBqlaEVNWtkIBApjNAcTlottij2If
	 9SBSt/HnzlLUzl7wrNxKlLDz9DgPTp/Vembv/AKwqR2SWrheQtcHxL4JXlM8zDbhUQJAp
	 uh6Be4hdxamZiZACAegP3cjuG3QzH7veCtwNdO5+Ia5lyNvNiRBMew+aCmw/UKLgaRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sOhISfoJ4xA00KTSFMSRqBNiRrUeh8x2nPQqJv76D80=;
	b=T4+XjGR+Y4Q7vUEDJUQfS1oG0UoArPnvAPfkOSDK/Ntac0cifmrG5j8Siz8FxJUZ8r5C
	 6n+XZT+DWSre8twq24WCmqBrLAT41grHI3+rNdjpKiDm+roXs4EL0vioM5zuYVjPtGDLY
	 eG6BtSvXwGdssPeadzR+A7P6PknX6WVdELCiFsmKGShfdAalaA9/esuzZ3/nS9foNkddR
	 sNRtmCZwuabj+Ise2W8+Ak46ExEQFLBOw4rkdlOvjshXvj72UID/fMG5PAompU1CvV4OG
	 q0D4anKlqat83/RXzs65KppOfPNdz8WOnXc2ruxGgsuUbsBgMaVxa9ipMdvYnevUXWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988417;
	bh=sOhISfoJ4xA00KTSFMSRqBNiRrUeh8x2nPQqJv76D80=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o0ZypCu0bd+jzo23l/5bd0haA4c9jocGV2LO3f5eEUlYIefhFi0o0HZXAYEE4YMZp
	 /qohaISUP1NNZ7rlwlfiRH0/hMEwnRVoIOOdGwRBeALx7HlH6f/E6ioh00NtZlY4RH
	 qtxvieDkxGbG00EzmeeduQk2vnAII51EcVZsJUtyEPKxNzehtbaJ6WpY7QGoEZ6hgF
	 cnPWJljMBf2MijqxF63nKqRlX7YuFlYTYYtdal3PqkFud2ACj1Qcq0htu1B7x2jlhX
	 Jo2dYw1PdPSgdjr3enm04br4EI4vs9bgxxh+W8hcqE43TqjPWVt0G9JKJ/+4H7j02f
	 h+oaaYgVIDnWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCF8181331;
	Fri,  6 Nov 2026 18:06:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C9A134D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4972160771
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vvYadyraxG7C for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:06:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92DAF606AA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=mzFSwx5Y
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92DAF606AA
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:56 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-84a248254f4so568375a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 10:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793988415; x=1794593215;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sOhISfoJ4xA00KTSFMSRqBNiRrUeh8x2nPQqJv76D80=;
 b=mzFSwx5YP1yM+DbE1x4ZgQaZEtlMjyO4oucR32gkjMBMAiBDZhhAvyeTylvkDqMTZz
 O3as6pjeFK7n5tfYPcDFWa7O+Ha5VJ9rFYrxp7TeK5pkyHvlvlqlNKcZN11xAr0Kw9B0
 UyysMjthYyQ2PFydJDEqo01YzxBCnFWUx9dks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793988415; x=1794593215;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sOhISfoJ4xA00KTSFMSRqBNiRrUeh8x2nPQqJv76D80=;
 b=S62UgZxV9ywJS6J/cO4d6r1fgdaRdUgumxcM1P2laaVoRxdsm28sN7goG5wbeupQWS
 Il2G5Z7tQ4HHVZHGPo7vJVNaTY1NBbyPO11a9f8cyC3kWySahCPQFeP7FB4GmPR9v46d
 q71I4Z0BzsMm4XoWiqyHOyvbdIgfbQCG14pL5GFYUe2XZxioBnm5rq2jmQuGN/B3Qazn
 3TR+eTfqG3A/3eRNyDM0nFZb1X+vMyEg/iJSCvJBMw6qTOwz2t2J2UcrsA4QLGMbCemL
 2o7LiNziQ9HYdhmBUCAOu3AwvH8vUEvJt1fulqKUHeM5edQsDSiFF6lCxU/o9YAeke18
 Os8g==
X-Gm-Message-State: APuU4Z8BZZurBvjXqtHDq5ZsUI6uZgu6JVxk5BhlegairvBGIP/TiSVk
 LEqGTP7ZaKgvz6oTS4JzrLHcFwccvnI0MDAX6bl7dooar6P6Z653qZfpV2/dwxydh3o/oMu38fj
 e4rQk6fsCA0qG
X-Gm-Gg: AYBFou21i2dtcAFZMg0vFZu/cQIJPklfCtnjkY+6a+vZTm1TZ1ZGTAot8UrztlHeu1+
 66sZD61DtGytOh/XsSg/7lfnqsnAY4ce0MnEFgD4fwH4PR7vWH+pt+gqqgS1xO29AMF28zcA50S
 Aj/Z8D54Y2zGJoSCmlbKxj4f2vx2duo6J6APHWmAEPoEzHG/Wq8x+3IgyEvVSUyxOKOlb4JM0qJ
 cGeuSd5IL8HmxQp7h3GNHw1jq51q5Bd+uy1Z6GVvxZt9JXvqvV/IyhVh5UmsjxDEHRzeGgc8jmA
 gfLiagmWum9mpZ190VDsq3m34i9/6SlHOENxU8MNGY2tNPU2R6h3G051SV0jYuVBy7gXM6KVfRn
 S8TDZG8C7VzSfEencY1voyleuGgVuLEHl0+V617PtCmtFfJnt2mEG0YKb+JS3BHfejnd5S7YYTc
 zd2Rs2dFgr2kdEhHjyT1kdlWqnPXkOCVfsk0JXbatnIlqksUnNdVNDx5w8E8lpCH0+UHN0LgTUo
 DvnkqMxqn8RRwnZoP4RF8imk8KBIs13JrEM1Uxkjh/LZv7oV6JWRTgjaQXeZI85mi/D3dCA3k4W
 Osz+joaWziYyEj7CR4zqWUsumrwlEWOgIylHICslN10OCmS7YMR0qY1EeekwqnOXRncRPe+rLHr
 bL4AtBBpncmoClqs0x+dkvI8qR8qtd9+AIziDB1i17z20GekBVWLzhHqdR5iDVLhItXW52TmjRd
 3+/GeQIK1cRi51r2dSPVD9nBV3ieTViA==
X-Received: by 2002:a05:6830:34a4:b0:80c:d34f:5f5a with SMTP id
 46e09a7af769-85f1d06e07fmr2984835a34.19.1793988415261; 
 Fri, 06 Nov 2026 10:06:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de8f066sm2440889a34.23.2026.11.06.10.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 10:06:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261028222745.2775066-1-trini@konsulko.com>
References: <20261028222745.2775066-1-trini@konsulko.com>
Subject: Re: [PATCH] Azure CI: Update to using macOS-26
Message-Id: <179398841394.3737874.16866724672713006210.b4-ty@konsulko.com>
Date: Fri, 06 Nov 2026 12:06:53 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 16:27:45 -0600, Tom Rini wrote:

> Azure has deprecated the macOS-14 images since July 6th, 2026. Move to
> using the latest current macOS image which is 26.
> 
> 

Applied to u-boot/main, thanks!

[1/1] Azure CI: Update to using macOS-26
      commit: cfa47eaae8214efbc8af51480bfbf4344d5e99bf
-- 
Tom


