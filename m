Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1167CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D53FD60746;
	Mon, 19 Oct 2026 08:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cmdCxAQvfrkI; Mon, 19 Oct 2026 08:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D514606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792400266;
	b=Ez/c/nWauI50saYFY/Sx32HOAQnDcCQApPJn05cqEXCJQw/HfwMFyYpz1lDSN1zsqkcB
	 SFsfHlwn5rPNiP1iCUSHRbkJNmn2vhlYYCefCUOpBX94qDpNHe3itfLFM61hdiNywpAwb
	 KxrYwHBvOD5LMZW4ZUaRCrAcXLUJjXQJ8ZDyq+v9Pr02A5A2ixylHHK628EcOZO4KDM9C
	 I1/ILNOZJdIYFcKWWw4gE7/4cipLEebXyRpgQ3X0jc1NsfHrt8ePcFjWbC9rFTkvhMCRf
	 tKTauTP0xgQPMgfCBPDkypFqVAvR6rOgLeuF0iPDg9gEuuksldXbtzDPALK40ofG2tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400266;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0lSGjn95C6VPD5VYFS95sKxyBrHWQ2sfdXdk9/iiORg=;
	b=izU6Q2WYT8xSBE+7mGUCqAr3D8hARCrEkWOyHvF1YSGifa8ctXQONeACwl3L3T4AQ+hM
	 aKtI9jGFmzNPx/yMjDiQak/m3EvJvsXk9cGuFwp6i+EiD7a64YkYvQT6FloZT9zjw5cgx
	 C0Qco4qy6Qlvsx0AkmZYZ+fUy7vCsiBk35qUDhH/EukNmgHVBzOYm1UUt3BawD8xVbbGD
	 0HngOxqlwpsFX9XQsviJ78QxOpvvsY6v7P2/8gGkbCcly/gd8YvtbRpY4CwJ8Uc7Ln6/C
	 ThP+FMUG61kR+sXrsYJEzr3mPzgPBENR2wTjmrOCXYjuBKTy9SRMu0znh7LhF/xnJ8g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hajpyu2s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792400266;
	bh=0lSGjn95C6VPD5VYFS95sKxyBrHWQ2sfdXdk9/iiORg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QWaTSBX8t7D+mCA+6vJ8niYqCRPiCybcVRyinJ1GZ/4bRNMU05fzYzoyhCOm++nxD
	 Qc+aExUfJ40rRfI4f2kNH4J5+G2xlvs2sH7ggmoJrBQvxn00hTKDnjA6BLvanYokO2
	 LPbvezctuS4J4Ny2IAUKQXupW+s6O6KbpeAXwojOF7Pre6tYd1PVFMLOgMiRLFMPCi
	 44GqJDOkJeYO07yKsa8fJZZ900A6/PfUbtaYPTA7IzcIPFRTWMR7DZYsmUW0OcOvob
	 Y1ne42v5THpslCWEANvGDGgL8fLM8Z2jrQCXgCYIXvAqffjXlP8C0NdOSDsdxRxy+U
	 5zbRNSlF/ctDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D514606CF;
	Mon, 19 Oct 2026 08:57:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 87F87465
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79FE1606CF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vQK_nHgEJJg5 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B90460600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400262;
 b=FOjQMD4Y3nN5pUrCRASfjr9PpuWc8c4x+epajnGWjXQJUHI+aKQsTdh2YTSWWzjYoXZ6
 hcbR+N/mi4q5OhXSi5BJVQ9vhDgH5/6/tXfQVHjXdezhTWh4kimpbj+TlJ2j/a0GvbosI
 SaT1F124J4Ar/4EkC5t8nHzMCOsaUBbK3UGS6q2lsMFfNC61H0w0Nj4zMjgsBPdTEPFN/
 WuPkvMrHZgODVDkUq/R176uwQVdGH8+VjEj96CR+SQNRzOSTajxt53ASVqbT3z7Mi7VMB
 C81hBzT25Z686ykEqjzVlL7Hp+mnrsBXOW2Qm90rocPV97N/mBfy43rorDYrcw70E5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400262;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=0lSGjn95C6VPD5VYFS95sKxyBrHWQ2sfdXdk9/iiORg=;
 b=DuPfBb10DSXe4RMSLFUFnxmKJO2Mz1jHRjp9o1A+tkCjpoUF623O+Y9AzG++m9YW4byz
 GuJnME5EaXlLbidJHx4HIK0zn/TPmjnqtTPW1q1+IBHtRL4+7SraXRy9qtNdYHx4IVRur
 vtjc1TJGC+nLJfiVHkmBjzXTmiEYF3QQv6HjfjTnEHilp1Hr6A8wMvOULxkQKh9DF8XZv
 ZAY7ml7PpthAZGT0/+pFjBvR5zXhDq1XhDFglxg8JKkheBn1aC0GoVIcT0DPyqewbHreb
 hMcBDfPinUnMl7pKEGmtUmb8Atb1ZUYX6Tt5wPDgUDTTFzR4a63UzanmR65u5C6c67g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hajpyu2s; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hajpyu2s
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B90460600
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:40 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so2351438a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792400259; x=1793005059;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0lSGjn95C6VPD5VYFS95sKxyBrHWQ2sfdXdk9/iiORg=;
 b=hajpyu2spvbZ5Dgh0snVz0Mjn8rKDb7tOpCoxxdaCuKJ/SZ8144i+IsdqeWFVOUdAj
 J8rytWdHCH1BAaBWUmpE+1wIKqgWqB/yPI5ie2XuFh8uIO80uXqiQ4VVR4noI+Pn6zxj
 BJrc+SOoKwPtrPRLn/ljmVNLUVy5OU/RlA2JlL0W4CPuf1wT6m+UgsQFgV5t4sJCEhxZ
 jDMuJOUfQxfwjiFMN5NydbFj3NfgPIo33wBDV7b+zDlgp0IapY9IlLtNWPO75V76XaCH
 lAfK7u92myiTAMBBazVb4kg5segpZ74r1z7RFusEIq+XHRqC1JzY3cyuQ6RM0bmaNNsz
 VohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400259; x=1793005059;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0lSGjn95C6VPD5VYFS95sKxyBrHWQ2sfdXdk9/iiORg=;
 b=b+kKw7LUZdswuHlq5qZu2fWxHhro2k6cYm2VTF+1sOPqTUpkHbjHZhdSX8vCNAhdQT
 mIVIQr+s0znTaDDJK6GaBXwNZL0WG11G56FEf8leTiuHXAGJnP74dM2AywlBf8jEXuPp
 PDFIJiybv8UIKQEMKCpij2CNWBIqvydMyByfFc60Bh0Ep619hqJ+Ak+hYLyfXd/OOZp7
 FTnFbWdycyolec5c99l0/zkmtKH7yUmK9BAZO3EYeB1w79R+pNEe9hEJ6VwV2FPJoqwq
 eMyWzbr+wZw40F6uLdaVX5sNWrdja39GohGGwTFOEY0sIPUp3PTFa3raPi+vkS2fnMzC
 uN9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaIZ0M5GjDlUSfwzosIOS23nM6eBDDzGZ22H6LK3izhFBvyBp8BV7J4jCUEeY+PpJZXU50nCc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIZqoaoBupKtLL016trwdiRUMLZRFLk1xDfeCx3/2snNQsaiSrY
 8+SxG+P3k0wqseaoT15yZhvhNidjxP6gBBvfjzlHrdoWnA1As8/Q7CrrlvqKksfJNEU=
X-Gm-Gg: AYBFou0cllcN0dH1m+xhfive9OwhVSCftmlu34wfxMjCY8Pa9bDuq3Ht/SAFyaJ+zKi
 Cxfnr9RPBjbFfsPVp/wXNC6scL0FMEhC+hpj9A+ZYNKGgdZC2WIwBNY29R9/D5qTCNfkHkX4/l6
 aFduCH1Wp13JgXsjE6Zbha/gPOsM5F2/hUqxwLBhqjdXTGtqrB3L3/7ebHrmNKDsR/a96rFGlOY
 YdWZJl52fds93+uG6lvyv2zvNCDNxxEB6lEtrq60bHGcGcFbnhlFcqbovXIpNEvlZjWVqCKqegM
 4AFF8DiGM8Kxk4azLeSYi3eVaD4aB/4TSRiKm2M/uie32yNH7W75OGJIGakaotmtESQHGWRbISj
 MZgxq0deC0/W/7W+TUANE6aQttIo2JKlO9GSA7Y5CeQWN8hGfIyvfHkYxWmi7H+9uT49gveN1jy
 hlI0yl/zvWtM4BppYbj/j5M188cTHEmiVJAOsXXpDqftLKUFFPZ5zT09Sejt0PK1JvugJWdkr7y
 /TNEDs7tCCWStzfCUDJ
X-Received: by 2002:a17:907:d86:b0:c2e:3152:6a78 with SMTP id
 a640c23a62f3a-c419d931422mr446655966b.15.1792400258528; 
 Mon, 19 Oct 2026 01:57:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328527sm338958366b.1.2026.10.19.01.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:57:38 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/10] Fix AVB pytest suite for sandbox
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
Date: Mon, 19 Oct 2026 10:57:27 +0200
Message-Id: <179240024782.806974.13238424938859043833.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792400257; l=528;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=zWXo/eeRArGVuTSqOgM51QUQFkdA/gtwblIDumF2dU4=;
 b=Hhuk4ccSzNwsU+oB0VzR0zyhwhdvR1BO47gsDHgtKzvL18gST9QScKAeK5p/dzIr0cAu3ny+1
 aQ16tgQDYLdDEkVYkt00IOP5kR8c8rfa0/8MhlMRjtEFsMEcE9XvsJT
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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

On Thu, 15 Oct 2026 15:54:50 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> Fix AVB pytest suite for sandbox
> 
> The AVB tests have the following limitations on sandbox:
> 
> * The mmc1.img required by sandbox is not created when the avb test runs
> * mmc1.img contains a Fedora image, so avb verification cannot be done
> * The tests silently pass due to bad usage of string.find()
> 
> [...]

Tested-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
