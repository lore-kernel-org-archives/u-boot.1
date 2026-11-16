Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE93606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cQOTxkUr;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=dvdc2Tsl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72A6D40768;
	Mon, 16 Nov 2026 17:22:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9WN9li4IJsxk; Mon, 16 Nov 2026 17:22:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CB19540765
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794849742;
	b=rpX7jqihpg5SJbx+kty/CBTYgGvJyOT9nTKBcBunf0TSwywaYXHHQrVjhciks5C0aahc
	 vlMyvkC57H8oEY5POuB6z3WlOLsHP8eDZKphQn1jp6rD22TyCzrC928tCkc/AXMHoT1XP
	 2qZlwjlpRYFTcKBQC+lqfNVzL3zlqmanxKxEH/cDFb/7ajWYdkPb3/ZcoeK4/OlmHILeG
	 R0DKx/2kP3NOPg0WfHITH3vNvJunSWvct8QBRsDQ6T/7FFHsVR6S0AvvYdaqNNfhmElXg
	 Lo8RhVWmb7OrtQ8gqkOkwzcFGganGzy0TS3FQSarZst8NsY7jBpaOmIFxOmSAN2c6zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794849742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cFUPl0uc4I3PeFhOE+Hq7AT2TUS/5hkNneeJsoov7Pk=;
	b=tamAjQ34pl+CYHCQolP4zq2Uhqn0iAzOs6ykEMSN6Dm/0RxoO1VFDNVa+2kqUiOrJEse
	 CbM8J/cP0ZIUm2AJz28zzxWR+5DZykhR3MDi1OrmwWjh56SJG6xgrYLlkFDqb0jsV4Z9Z
	 repcSs3xlurkeKBCBjc0uhP1C5WdvhRP8sD+FXq6N9+mBqj4EwdrKUhAP2/pKT8i/Rs6b
	 IDBTFhaBdV4nlD6sTvdT3BEqVMPGE5PAXKLzbWyH7eHQErtvGTwSe0V0jBeV2UtihEhQa
	 AJFTA+Z8dNuuzJ0zfIvGrBqXZ8vLALgzdWCU3Mb7rFl8iCp1keEy61ZKPAuRmXij+/w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794849741;
	bh=cFUPl0uc4I3PeFhOE+Hq7AT2TUS/5hkNneeJsoov7Pk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cQOTxkUrVLLGS9K/7pMwdoYg1zXkEvrjz9Vw48zWSfin0Nia6RsJAd+Rgb8LjK0VK
	 RkPvh8tit1Uw6XEHb3bYgTvftI10v3U3jwai/o5ouaHMbM+K4PmmyEqxyzPypGwG1V
	 WSNOmMd6KCZs/+R1VTuoSPkYDF5L72N+rvoHhhk7VQBgPp4eIMlt3wyrXD4mvu9KV/
	 1NAyyaLKI3OXHuZlLtBUzR0JDpuVwlw6/oFLhmIhHtTb6XFB2Or+POUv9xPewLpiqj
	 vbsyMVDhYfIml3DQc+Ehh8D4eAYyNrNlVTN6oZtees1Y7Ux6fN5wR5fqDGeB5ACOWe
	 jdYv1Lc9LKyqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB19540765;
	Mon, 16 Nov 2026 17:22:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B3E6828C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A626080CD8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TaFNBVu53yWa for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:22:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0EB7E80CCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=dvdc2Tsl
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EB7E80CCA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:14 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-862a19300b7so884443a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794849734; x=1795454534;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cFUPl0uc4I3PeFhOE+Hq7AT2TUS/5hkNneeJsoov7Pk=;
 b=dvdc2TslYewtrlp/BQu8l+Yte464MKhyj48tAGiVtIC+p88yoc0yX29yiZnvPxi/3n
 6O7sGqo/eAVvGkGjXCpVTVOb/RRXGxYn8TjS/RVrAvuLwHTALAOS5n3aLdNuEYE4lm9g
 rcqNlVfT1y2V1G50GUojXqiLvxZpmwvGSXTHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794849734; x=1795454534;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cFUPl0uc4I3PeFhOE+Hq7AT2TUS/5hkNneeJsoov7Pk=;
 b=JmSKgjUSv0/uz5Xti9NA/FOfFl3eu1Gy8suub4Du/oIbhsMHf4I2a5oQi6Jewilzag
 sRiNNfDKkJzxpGJYX2G9XTPlamGWRI5MhSbU1XFw1VF9+3kFH2oTf+x5XrmxeEXEGn1+
 Dh/w3mapBkGxKZDm5VZc3RRRQQINrE50LooTBbN88ltBttwexj2OHWaZzQYSgTRYoWtM
 BUO/LUk/QVVa7qyvbbqaff85MR7IamD47CGbRXdY+EcqfQgKfsFkJnXsDLRhk5IYenIy
 N625U1UO1rRbAJfefbq9RgKDg3z06QN/SihgpCS8QYeC85UGxTGI8k2QJ6k9Tu5aCaAa
 +bsA==
X-Gm-Message-State: APuU4Z8PQDbi6r0sYFuVJsNQIcPsWQ84vblPhGznhQ3zi/FlJIo70hIC
 GVBNfSY0J3hZ+D2rMxT1cH+cPOJK8vtf1Lvl/xZ8XhTa4rzXVB9IHwzlQgZfPTPPJea3EqaFdPe
 ZpiMVoifp3A==
X-Gm-Gg: AYBFou3ehTZWipVFJIhboKZzra5BjP/3uCIpcaxzlRhGImpXQcljElAyAFZDtAobTaf
 mAPgdxti+RL5jdl54u69Egm5oTkjHnHnQI4dh5rpqrJVayrI5tm2bjFyj7iGff8d2YJhfm+3QU5
 +aI5vi/cSWPsi1NsezWW2+SL2Ija5D59Np27UBEQsbxKt46Y8Sp8KYW1En9NvxixXZ33w/ael12
 /rmDawR4mNCRwCa2s1UOBbpMSb847Y0o7JkREe2yCnL29565Y8yYkjFO2OYTAZiL2Pz8INMkkH7
 3la+ioO3cGWsY0kVUF3TrCm29DpdinHUOZBQhtWFLqf2KwakydKISBADOAEjWBsfF1+35fJ7v+r
 RTmnGVkGdTDCJJIJhwYPUKMYpVWd5WQiH1dZX554Tthmboo9l0hI0Dsw2STv9oYK3j+xlMGRKOY
 M7r467vG95Tsc7LMB0MmtegK+1F2Tp0nZCvvyrNqlRG5jnX3RAYgmiOmyjyr9LpGaIfYr/6AESH
 F/Xc9DiMnMALneESGk/xlP3nlfH0MB+0P0npixogEvgv7RPkvZM+vN7J2cTZsBh3aprLoBxtDI+
 3BJjtWjtcdGFd5fMfrQva8SpDk1G4g7WAQ62vV/cvqXOePIUXEMqP+vWjDj8yhsiE+qSCO95SEp
 16iKOpfnXgazB/2HwFKggPowisMoV1pLtsN+HB/4YiGYWoDM2aNaRWm1bnd+d9lYIfWiNKBhMXP
 9O6ArcOBKD/q6bH/iHZIdy/1BrUSsNzbY=
X-Received: by 2002:a05:6830:3116:b0:862:ca2e:919f with SMTP id
 46e09a7af769-862ca2e9facmr4228130a34.18.1794849733946; 
 Mon, 16 Nov 2026 09:22:13 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862a82c4625sm7191658a34.22.2026.11.16.09.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:22:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 "Terry Zhou (Synaptics)" <terryzhou05@gmail.com>
In-Reply-To: <1314c58c-fcf4-d829-1f2c-32dcc2bacadc@nabladev.com>
References: <1314c58c-fcf4-d829-1f2c-32dcc2bacadc@nabladev.com>
Subject: Re: Please pull u-boot-i2c
Message-Id: <179484973318.2141271.8977874878108289310.b4-ty@konsulko.com>
Date: Mon, 16 Nov 2026 11:22:13 -0600
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 06:07:03 +0100, Heiko Schocher wrote:

> please pull from:
> 
> The following changes since commit 3cb2cbbc75aa7fe2391f662607d6b2f46c1292a7:
> 
>    Merge patch series "imagemap: structural and cosmetic review follow-ups" (2026-11-11 12:48:04 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


