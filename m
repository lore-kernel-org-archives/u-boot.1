Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2628606A893
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OHj+PtkC;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Ajhrm1Q5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C503607CD;
	Mon, 16 Nov 2026 20:04:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 84FdAKt8QL6u; Mon, 16 Nov 2026 20:04:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F220E606E1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794859478;
	b=f/4XvpwP2HAdjk3ocnoNGQsSlIGb9332bgD0tWZczgoFF4Ge+T5aDWDunPIP1ouJRdqc
	 7iP3ZryrgruhLmx5YSqIgl39Uh14CDwYNWJyhpL6d2EN6FMzjGApWP5/YopoUQrufHwoT
	 DD2jcvWr+SKdRppXUq8K2tCbyhPjf1reGkefA4uYUY5HpyW1YpTaMY0YaShW/1NTfpQS5
	 e/AA32SnNtPwpdR8c9s6dumwXVzMzGUvCg4ZXNztr9vWdW9oOlPfmI1m5q8fSEyBmYHrK
	 9ytqQMFK4q8mb8QwlHZ3v6v3TAS0kCT/npCzYMOURo+Mm86QrxkCfbhfEBD4d0tttvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794859478;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/Or/fRCXnHcEnYzH7j2fQB/YC5zTsvlvw1YNULHOdZY=;
	b=Rgkc6VZRjY/DC99aaYBlda84WfQX+Vr/ZAEBFd130mgeJcAZ21Ruo8u2Dh1d/dQkC3Yn
	 2SDWQZ60b7obgsw5/lfvB9trN8EHzCx51GcWH3RczrDnBFSgl7W5Wu/AfcLzt3LlNc4VQ
	 WetdBTx0xAdXoazjpspBfQN17m+XUmwA4oH8KGHTAr3urWsXHLrF4Ef1Jag0lQ7krXwHx
	 JoPJnt+p30MulI/rGtV91RHsaeZbBWMpi1wttZMZGroBTK4ZoAC2SXeuVcdw/bXxBC/nX
	 alUoKRZpDOdfY5uRcrhMiccCjfAmfD9PXGOiibvtCvPP9LdmDuiizsRDkQJgOGykjSQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794859478;
	bh=/Or/fRCXnHcEnYzH7j2fQB/YC5zTsvlvw1YNULHOdZY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OHj+PtkC6VQhSPGCGaw0gSJi2VqQrjce0+gf/1+z8VCHkede+ElLNQxKNbssdwSwN
	 pzcxIrTHxVMePit1LBrE5OMpO/eXjZzsvO+zrXPcgd858JEuTu9+xOhNF81KBF47p+
	 iLdTH7IlJzMAb+s56NfMmnLDgH0mPQwWko9A94+9ank5DpX0ghWdX6668q6kjpJe/C
	 1St0TBm8Cq/IZfpVszKuqrGob5/od6DL9aLgKYbEFwbYhUyKxZLyTc7j9nQKh2dacq
	 7wMkoVcnzO2ABGuJaDU0MDWGpsQj+M1lcfDMvGWklu7IUxpL9cQu+P+j12UNHcrnwd
	 pkNyTMGVkPHYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F220E606E1;
	Mon, 16 Nov 2026 20:04:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D94E21E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB603402CA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:04:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pX4nZK6Jw7U4 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:04:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 261E7402B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Ajhrm1Q5
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 261E7402B5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:04:32 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-86298f9267fso1955366a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794859472; x=1795464272;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Or/fRCXnHcEnYzH7j2fQB/YC5zTsvlvw1YNULHOdZY=;
 b=Ajhrm1Q5/0VTwWzWAIqfcss4mQSfAUHO2quYrXCZcfUR8leJj6I+BZtd0czVq+qpCH
 LPySWZVwg1jDOj1Pk7k7s8tk3T2dcPVLW4ZIWgrvuE/omOr65ibYbB8ex/UjGz084bcv
 QdoqeRlxFkx6BXlG8RzVpy+d183GIZsC9pz98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794859472; x=1795464272;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Or/fRCXnHcEnYzH7j2fQB/YC5zTsvlvw1YNULHOdZY=;
 b=gmthCwO+8VCYpm20azbBbQm3QRU8GhbrvTl/J46SMXZaBgd8eIMVyj30w478Eg5EyI
 BXn8OJpS7DkbRBWC4V28X5PluhxtEAPNdK7EAxa8xb5bJC1Gk3s7G4QzJucA82l8tipg
 ddXJAjmsv7/POZyysxRTGI1OKKuJRbn/LDQTrsUaCf4sjakSS5XcsTknOheuSWH0Jcu1
 HP3oc0P3CdODBOXZxAY2+MVHcbiTIDdOL2F4hAqleE3+70ir+wrxbsuTLb53OThYbD+v
 roLNI8mvHsALTLdg2gogakVu1YrInd+VW8D/BZayQrlMLOjpwwdik9s0TRYZZVNFNnXB
 idFg==
X-Gm-Message-State: APuU4Z9+CjutephY0N1xvJLEkVrEtb6OV7nlqzfzo9nOFfvWu9Fo5GWS
 ivT/x59CPZjDxZKuFU7f7e6PurMo3r69NsgQ6qrE4OefVUu0lbTgVZaFwuFkHGxVq8OktnEA9YV
 UKAJSUGE69g==
X-Gm-Gg: AYBFou1Jn9v+zO4+Pj2E24rfve2rWnyFpnl+f/JVzURQ/54CJ/Bxq2a+aQCIDtMpMsK
 xtwwabICNU5MF9KschgAYynZSFQTlItwqwjOKuGrCW6dFpt4yNbljK/WlaW2TR1cTwsRYP8XV3t
 YISJGM+/c4aRsokEQ5wcrhP4kf4najnTPsyaPdy3FNXFk4P/YV1GGqaAX3oWMk9oaOa2V1ba9L0
 SJetqq/E1jCwTom/Ary/72WfPK24PcgtnNAHBcoP0x5mOzliZBK6UQqHRFRgf5oaDNOXI8envJd
 eTedKEjcqLWSaH8MHLAEeQxCY7vu9p9kNRy9eqcvuooUZrPE5FNdWgkPBSyEj9ZNGt89WmIX9Fg
 wa6HaBLhH1Gnypo+kIZ1uHWN9oVqoPzPTuVS9VFC3X6BJdQhiQQAScvwe9IJX+sICxAd4kzciua
 2oU1tyG/NksU6EiaT2RvrKcLHH/5B++IlcQBRgPMRwDATqgnUlCG8GV3jJsktNQvcL+1Sq0UmXi
 ojx2csuS5LykT/K9AzZvrV/YoFux1xFa3l5OXlagfgcyJUjvQGGLhJliNsyJu/K5kkRAt88g4pJ
 TfICUR0pxBioWX3M+KWGGJKhttdHl4/4+iucUEYGApR6sT+Y69ogEwhaYunRM3GCBrqvIwPQLGz
 xHc0MBlwyls7NHfTukZl5I9VLo9LRkx2kEXvqG+1/m/QrDAtRPwHw+EH7GArjJsE5DKQbteYoKF
 prpWJOLMNrUWhRhhjnAo9p1pQKRdKJog==
X-Received: by 2002:a05:6830:310e:b0:85f:ee8:26c1 with SMTP id
 46e09a7af769-86289943c81mr13867049a34.22.1794859472019; 
 Mon, 16 Nov 2026 12:04:32 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880e9abbsm10790881a34.9.2026.11.16.12.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:04:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261103044036.618125-1-trini@konsulko.com>
References: <20261103044036.618125-1-trini@konsulko.com>
Subject: Re: [PATCH] lzma: Update LZMA SDK code from 25.01 to 26.05
Message-Id: <179485947143.2548598.13934766386304923577.b4-ty@konsulko.com>
Date: Mon, 16 Nov 2026 14:04:31 -0600
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

On Mon, 02 Nov 2026 22:40:36 -0600, Tom Rini wrote:

> In order to keep future maintenance at a minimum, as it has been around
> a year since the last time we updated the LZMA code, update it again.
> This brings us in line with the 26.05 release and there are few changes
> here which have an impact on us.
> 
> 

Applied to u-boot/next, thanks!

[1/1] lzma: Update LZMA SDK code from 25.01 to 26.05
      commit: 6201222134cd704b5717211fc917e2ca6263577a
-- 
Tom


