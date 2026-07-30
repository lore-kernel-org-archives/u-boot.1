Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8DBC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34D8181011;
	Thu, 30 Jul 2026 13:38:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FcRbAR12ICGn; Thu, 30 Jul 2026 13:38:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4372E80F8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418725;
	bh=BOgcOrgmXUI01lS7G1TkT53I8GCS17OJ3ePmBW89dxg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f6teH8cnIyMaZR3waRbLCCAd04Vodm8Qe4QoUCh5CStCbnC5GWrRanTpCW2AiU3ZV
	 AwRQI2B3Ywz2GtX6H2tmBcCPSB9c+tRyFDlzFW8cPqZSNf0GqbCKeuHZQ4O8AD8ObY
	 ZdzzwH8EY/FrI8gV5y1emrteGPZJN0vDSZIB4ff8B+E0u1kcqU8xWRRFzQD3l7STnM
	 oS396wE4GRmenJYBNSJu2RhsOH71la12GuXVXTfVpHq5PfdAbcvho4E2Js9LT4mRLb
	 N4V83ih3yiBMFO1FYO6G9fii6eaBpNrTN8Sezz94acH250juvlPHPNodexCWfSklQL
	 iWpw2ypWyhJfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4372E80F8D;
	Thu, 30 Jul 2026 13:38:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB7F8197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D15F84022A
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ql4J7Gf0tdqq for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:38:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 06B53401A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06B53401A3
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06B53401A3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:40 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6aae11ddd13so1447561eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418720; x=1786023520;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BOgcOrgmXUI01lS7G1TkT53I8GCS17OJ3ePmBW89dxg=;
 b=mkmkFHlggGCDOL7E/hslZeGfVW6FzTot0HyVDkDKINu6zDOMVz71ohkz799BPDm3if
 Imtb0VZJWwCuGphtDhqgTSWx6DaxEpEY/8sDn5M1DZhby8wRTeeaCKgL26uWFXWShaFC
 Im57c6xVBzSO4DNtBeth7MgbiDF1eIxImKFHLUsEdgSDj/GQFNxUhqc1F8EedUsldkR3
 FKF1+fRSYWza/okaOf5S8Q9JWoRCMjJkv0irGb66tVVHLvw/zH7VDg3ENztoL6l6CLU0
 6EOZzfnHnBE2ciRFW/RxF9OmrZbwIXX8S746El1L0tuJ+e4MW5dgVE9e5kbAZF/abUEc
 OhaQ==
X-Gm-Message-State: AOJu0YykNQvgapW4+CVA/axAAyxZFqQnPdBx/R9VZNUl9/vyISC84zev
 NdthS4QuMyKv6CX75B0OPaRnmH1BFRfiZTjPe8x/zeXFhtwAQVBQUBbryc96V7hGnXRmJQ+ol1I
 TVm309nU=
X-Gm-Gg: AR+sD13c1ncDdryX/QXLZweCWFleDgfZEl/RIlbzostFqQasFqGitHKVYF8/96is/gR
 0Ow/kLy7mqve0vNExOp8mUtafjwHtF1JrMJoP40grHJxK6b1Cuto+m1sOPtRF/h9Wchz4G7vBCG
 SRpQRSdO3AU5JZkaZdY1JWDeubfzCE808r44WMZ8vJi1iVwsjmG92jHOkbQjWxWgNrtko76d+Nw
 +dqrtFZ1/VQvo8RUKmyxg6o9ZVBn26HD+1rtK+qokBg5PZM+D3z7Nf1v1vagsIWzgTySXOIUS/Q
 yJgB0lh38GL2ZJfPCiL836mfagThOINC6bd1KMvJePyp+nT0WJB94ORXUAbt1djR1yCwKzAd+xc
 I1TqB4lt4xGxZxDE0DICb+Am0TE/axPmBcE1rIGA5GEKbBGHFdl+/MElvrb9lP5NMrnpyaUQ0L/
 pzxhPawPUvWQOKspZExdJjrGPwO6+8tPt1TtHWaBxiyzQ3Pz35vgaqPMdYNyOLEeBO5mvwAQbJb
 KSwwoI0Yow21lNsvPcPCvmRgsW37arEAvfD5OhnAOCA7CoyKP5PdsASdxkaG+Vzw3iQwMIPQa2i
 v77VBL1cng==
X-Received: by 2002:a05:6820:624:b0:6ac:b9d7:2170 with SMTP id
 006d021491bc7-6ad02140488mr95385eaf.17.1785418719891; 
 Thu, 30 Jul 2026 06:38:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6acbc554a5esm1457983eaf.10.2026.07.30.06.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:38:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <cover.1784423738.git.daniel@makrotopia.org>
References: <cover.1784423738.git.daniel@makrotopia.org>
Subject: Re: [PATCH 0/2] rtc: pcf8563: HYM8563 support and unreliable-time
 reporting
Message-Id: <178541871910.2173019.4972741283199567744.b4-ty@konsulko.com>
Date: Thu, 30 Jul 2026 07:38:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785418720; x=1786023520;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BOgcOrgmXUI01lS7G1TkT53I8GCS17OJ3ePmBW89dxg=;
 b=lvIJ/9Eu6rPU4I1OpYdGuCP3nx8p/jVpUeD6B0LOdx/h6nU9yIGNIPRkqUbBHL2Fox
 YTkkUnhNlbu5pl66VE/4NAZeT/f7lKBjOe0BtVYdV+ETxhGHFCmWWQJOEL5sO4wR6tmZ
 RmhO3zMAudsD9T1ZEBnGtXkfFUc2eGe8G+3sg=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lvIJ/9Eu
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sun, 19 Jul 2026 02:49:14 +0100, Daniel Golle wrote:

> The Haoyu HYM8563, found for example on the Radxa ROCK 5B, is a clone of
> the NXP PCF8563 with an identical timekeeping register layout, but the
> pcf8563 driver does not match its compatible used in upstream DT.
> 
> Boards fitted with it end up without DM_RTC and, as a consequence,
> without usable EFI GetTime and SetTime runtime services. On top of
> that, when the chip reports that the time may be unreliable after a
> supply voltage drop, the driver returns a bare -1, which callers
> interpret as -EPERM rather than as invalid data.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] rtc: pcf8563: add haoyu,hym8563 compatible
      commit: a9a289a211f7e6b479afc3e5f0c07c56e5d6ff7d
[2/2] rtc: pcf8563: return -EINVAL when the voltage-low flag is set
      commit: 9811c57b2e01398c6f8ba29a63d93edd4ffe6482
-- 
Tom


