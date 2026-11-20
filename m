Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B69606A326
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y+n+V+Nr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v9S9hjNa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB50440DD7;
	Fri, 20 Nov 2026 09:09:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2MUgpn9xkmLn; Fri, 20 Nov 2026 09:09:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B7C040DBF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795165742;
	b=H9TB0pZa6tHPI9femYE5jnkoA67PdfoY9zxZABfNl1Po0RLNLsX3tA8lmkkHqAFeI6FE
	 yTqvHRQ5xAYznLthy2QC7G/Bq97kpv6sG+gRjz/XzDENnISXPoLBgjwSKorIIOwIutOkB
	 7DgpQyH6wYU7/bRXJo9Qa1gy4PB4RjZtqXWiiZIjYJtwVbvKuaDtmYx5YUWBffUJtN7aS
	 QMSKVDKkY7D/8r/z+dHYapMLPrWKkXz8oTeBR9iSYcg/sl+dDFzQwqnG2nZ5JpZMO8Ws3
	 MZM80P6+vqmJYgpYQcHVqcc4yucikbY+BfB4CnGT6yftyDC2QM6OiZPoHdvvuftzuqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795165742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0FDGpUDeGON4qJko4J9gRhia2SHlpxZ/d87hGg9BU6A=;
	b=cRiMZOU+Vcx445OI4KAcuRSxYXf/dXuzXC4iN+nj4/LX45mP5O2GZ2GzPAM9xOKjYItS
	 an4yDaBXr++7IBSVrFZuxm8BongFRm1YD+WNc5gn7eG1ipNfV0fGmfNeen+o65s6HHAYz
	 lidUkrpF3A9MEqcnJC98VvuvVB9HfxRE7j4gx1jCJ9P2DCg2t8E/x1APV0NolsQ9jg2c+
	 2E0yFUQ/2fyd3xQ87oxVdiFxSeibdOvIDGI/0BS3faH1yYboRAQ4dOdiE1HiR9VGsemNX
	 a3JAUQZvwcJ0/o1IpknUbr6fZbl6NSKBwJTYOR9tWkeVVxvWDDm9rRIZ7tXc8nDn0sg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v9S9hjNa;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795165742;
	bh=0FDGpUDeGON4qJko4J9gRhia2SHlpxZ/d87hGg9BU6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y+n+V+NrTiwFI/do9xNLeMsl/7lYtozIOo/qDENBhrLnAJC9+avsyYo7DBPEn1+mu
	 0xHrc5y0GFVVtJUNBjQnNnvU1GLYU9ytf/J/wHOoZo0Y4IRmnunQkOEcKzDat3kRdt
	 LAxrNfmDAEPdAK/uQAeYGeRt6LW3wlJcIgy0fNAzy9qVhw5aM4APU/odK5ViLDUrhS
	 qELtd6BllulqXT1CzUHxooGAjLaQmvPv+6vynHYFAqnDLcU8HJbxDiNTeWMgjUhlAO
	 tRrV6FEilVRkEEZb+HmcoVwD+RKjCWkm9Yw67ybKESqu/FaFTZgagbeXcJHCD+E+Lh
	 FxY2UCmjtex2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B7C040DBF;
	Fri, 20 Nov 2026 09:09:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1FBD70B
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 09:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F15F40DBF
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 09:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id evPCAl8R-BYH for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 09:09:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9986B40DB2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=v9S9hjNa
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9986B40DB2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 09:08:59 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so3887975e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 01:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795165737; x=1795770537;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0FDGpUDeGON4qJko4J9gRhia2SHlpxZ/d87hGg9BU6A=;
 b=v9S9hjNapCBIrOcr9Z64BnL1t56u6qy3M2GqMicnZkzd8Lg7cSkYAGzrLdDCxfqsJ+
 NhawDUcy6B8VrWqjnuDDcITPkHldiD35xf+NabzvYtdBNe9ZcCMw6OOTk8swKSZzS2Bd
 9cH20jQv4w4KcgGnqHMqp2A08p+A8/aDm+ONCBTt3gjUK82mzB2YA1kn7USrifAXIyeq
 R2nD795IuC0KkFBY7P2wfzrqNKTpUPV0iQ47RDNMZXKOIkszMx3qpNSPL2YxWUmzBd//
 8L6YjFCTEcveCnbFuSolfnpQuaqca5seQSqK5c9LurXxC4bdsiLyfgQ3xFTHbmSybtfl
 C6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795165737; x=1795770537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0FDGpUDeGON4qJko4J9gRhia2SHlpxZ/d87hGg9BU6A=;
 b=ALNP+dUVOdcRKALN5CCTUblluIHnYZMD+Qs30Wwop3l0GTg6oTn8570dQj26S8pAHO
 GGA+6O+pva0ocWWBffxaANFQ1jTaCdQ2ccbeCmBp23h3FMTT/HBaXds/d+CS6e9KD1R/
 4BGmF9dsoLjRUC+wfcUojO5x6Yaz11AUiQWPqnEKOywp2K/Ikh8B69mdv1u0rfk7ikh9
 US5L6OSgdVJZnOd6hVeGWW5nz8fF519ypA16Cpwj3JqdzsdkoNuFF848AiPCixbDDXsd
 Ez34Y1lpUzGT1ifIkBPn2hjJOrHwo/RO9mibcsKnPRriiBQVAx6Dxs3DOwX1jgc9Of8y
 Aihw==
X-Gm-Message-State: APuU4Z8wsJmuGh2tVn+XEA0jW8aWv7aU9kJxbybo7O7QM4OJVcQob23d
 RpLbE7DA6PW5MH+0Ayxul+OQnKYA1cwMEwAq5ZqwKOLNmbx2MSzNtnRA
X-Gm-Gg: AYBFou2mBT52kVtevzdpEnQ6LgXn9/BRNjJ9sGskCzl6J1EfPAfacnrjVhsJjl87uU+
 Y1lXUm1YT3dOOel4F49z9cM17eGgl/CF9wPj/nFDnUihfcsQx5iaOi1o5vAV9nImqEmFVbOCqdI
 MXpe/wJ7PtyA3pD0H5Ikut5OByWOln6pOJKz1pWbewd+LFeceWX2Y2njI3rTWfzPwh/lPvdOaml
 5OVaYUJOVLFD5IZd7Y3kfn3gxYcSDe2tIgwKhQSbtiEeIXjOZMP94sMBoN+nKBooYLJKL+lHuMO
 YtkYMVgV09ad6UZPiLEFUOEf33bXtTpqOdPO9GZSnepeDmW5+f6vRlT2yproL8TwsbjhnwAO8QV
 E2teCMvZMEpXpg1A7YP+c2rfBVLxwVOYAYPGIg8hf5tfG9b9VkvAcr7dvTWjsqJbWMUy54UfMTd
 YdslpPDzqM3JaetevkXOvh5L0t9ps1xiMIHOmNKw4WfJjx1ZPSoEuehlHPINypTIenjnRkasTuu
 x4eXOjvYC+p0C5gVqa6FPidpRN6vCDN70olXfPar942TeilRog8gm/Kj+kzMMeGASvX92DlIOdj
 d7ckvz4yOHUD7IBGCUGnd/mOja9nhw92fjVGB9PX2Xn7jOm6x7HyJXgsk5ZNuSezRv1owa3nODk
 W/2qYgFK7r8nsTsLILjJGKJ2Dvk4CdsB1EqTd5CDeg+JZxbzq1nmAoeHlvWHElLeHfbXEOjSaZ5
 Ojp7aBm4gwtGSlLVu4ydDzuqrlDsrsSx1l8YTXmTLAqbMljjDrUMS/Dw==
X-Received: by 2002:a05:600c:1d09:b0:4bb:73d5:ab33 with SMTP id
 5b1f17b1804b1-4bb88816acemr50865315e9.22.1795165737138; 
 Fri, 20 Nov 2026 01:08:57 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-9194-b982-8e01-fb27.ipv6.o2.cz.
 [2a00:1028:8388:a84e:9194:b982:8e01:fb27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm114112975e9.11.2026.11.20.01.08.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 01:08:55 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: u-boot@lists.u-boot-project.org,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v3 04/14] powerpc: lib: Add 64-bit division to the private
 libgcc
Date: Fri, 20 Nov 2026 10:08:54 +0100
Message-ID: <20261120090854.4425-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <4B9B6E83-2EA9-4663-8A98-73BB63A713D0@linux.dev>
References: <4B9B6E83-2EA9-4663-8A98-73BB63A713D0@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bradley,

On 19. 11. 26 19:55, Bradley Morgan wrote:
> Well, Christophe has the concern, he can assess, also mind answering my
> question about the user?

Tom asked to update the common code, so v4 will convert the callers and
drop this patch.

As for usec2ticks() in arch/powerpc/lib/time.c, a 64-bit implementation
would divide by the constant 1000000. With a constant divisor, do_div()
uses reciprocal multiplication, and lldiv() relies on the same
implementation, as does usec_to_tick() in lib/time.c. GCC 14 at -Os
compiles this without any call to a division helper.

However, the overflow described in the comment is in the 32-bit tick
count itself, not in an intermediate calculation. Fixing it would
therefore require usec2ticks() to return 64-bit tick counts and
wait_ticks() to accept them as well.

Josef
