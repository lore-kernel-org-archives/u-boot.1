Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C63606A32C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tugWP9/9;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=WCKF798Z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C7D2409E7;
	Tue, 17 Nov 2026 20:03:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qZfEKy2i419m; Tue, 17 Nov 2026 20:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 25265409EC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794945798;
	b=hzBYEgCVqdWH0mBYtqLcmWI7FFkQeiHlgtpwxT5WIc5RMQzEpgf7GrzQCn7UZyEedXc9
	 iFdHM7RSOsYVzjiYTw9pnSHaSdbXvgTj/cJhd0aOh0HxrtigYmt0KSWMPDA1UOrVD2ZxI
	 YtHLAvLykPLF1exDfqJnKnnXx0HkW8gDiwlfb5kKcg/V44wzJyaimB6MLG5+UfjUfTUDQ
	 ax71Mn6n9uuGiIdjDXTCzhHrFTr1StgeTmUn5Pa4rMik3/AO7N7sd4sMsbKSjcSg4bCHs
	 1RBI4yJL4cJl9GkDYuOmma1ebNzjY4wYm8o1Fr0SfVbNpWuoJ/veirrfL9VHflZE9xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794945798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W/j2/QgxkP5lqDhe5vNRPKsBsMeePYwVt3q3fj6kYcE=;
	b=UZx9CBm5TwjYzKVWCxqH0ncTYxC2LxUnAcsUPK/Xcz3hjdh+52Unv0qvojsumuoha2Al
	 4nKhuiwSK4bi3fhx0z3ZPHeepgIW6DKAEKyE+2dFCH3iBegTzk9ZF4iZhsZ0xdRmICTV5
	 QmzfNbSHBukEPELi8bCi4T95CplUliTSCCrRzCWzOhAJia3KEQYva6c5TxnvGM4hKrO6L
	 AEkeF9NblGNiV4abdFSfzsWALMnDScnsh38leA6rDB/oyRRHRIIpWxUW7xQQndQQgCKPv
	 bqvGFEnK/btWqXyePYNUmVCK6P79zJzt82j5EN8nULesnanMl6C4HCmzwSwbOAvguxw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794945798;
	bh=W/j2/QgxkP5lqDhe5vNRPKsBsMeePYwVt3q3fj6kYcE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tugWP9/9Izsz+P5WXRGFSpOM6kBjNudAtgXMct68OnjUsEtwh2QdJl4IWcVy22cIH
	 Bmh0rt0S59cTSRnLDASpjY6b7mfPWchD7omBm5i/GmN+T/lbBpn7kWwFCDx4P0q5lK
	 hPpR3vf1lzlf0Dwmb4KOA3JamCyygH+EGaB+mphhfR2Q3QBYs+9Lq3XVLFJlz9n5Zv
	 MQ1u7N/e+RF3vUix6AO0nNc1Vn83xYDihTXi0MbGz7sUZ6tKoEZtHtLAVKKaEU5bvG
	 OEBuSJlP3KPPR4i7mXumRZk3Cn4dI2pEQnVZpOB21chnkE9/Xm0/ps0ZdCO7iw2X+o
	 A92T0udGj4OpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25265409EC;
	Tue, 17 Nov 2026 20:03:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76E2949B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6946680C9A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NL_Ngh8IIlCp for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 20:03:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C138A8085A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=WCKF798Z
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C138A8085A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:10 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-43bf9548df4so224139fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794945789; x=1795550589;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W/j2/QgxkP5lqDhe5vNRPKsBsMeePYwVt3q3fj6kYcE=;
 b=WCKF798ZYDJQKOSHTBHuVKBmnyCxfJb2kWVPkzzwtOWSNopZlcoHnifRsht6w+s1jB
 lf9Ad21Nzum5xee2LC7HcCKqhDRSi1XpFzVyXIXKshxb/OkgaiTJumtbae/zL2dpdzM0
 8MMpvdsdqo1/s6O2vgC4u0yQBn/qa7FfMJDok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794945789; x=1795550589;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W/j2/QgxkP5lqDhe5vNRPKsBsMeePYwVt3q3fj6kYcE=;
 b=NQcXF6b/i65zDPAQx50Rxs+iX6YXViEbFg/2VhEb0hkbePGWKOEyeALYZ+NTc5LnbT
 XyhMB5ZKT0pR6LeRqLnH12WBmAjxFI9nmBc6+l7Cj3pEg8XnsqGqp+eaOe/xQaAkRXXp
 38P3BH70E25BNq7DowMCQcOz+QUwX33y18tR9/8WqQQHRhHYbbnoY2E3nJ+91H282bSC
 aPFESEMiybh7+QsTn3YsEOMih3cCaCRPxVZnBM/EPRINCWTHy/lEfKr9btAkQ50c2Yo9
 IzoNCzmX7ePgnm6kF7pLqZdpogYS7zx3WuOQMhT+Ns09q2iHix7RrcJD0/TFRsE6jauo
 btbg==
X-Forwarded-Encrypted: i=1;
 AL+hErGEWVyzW40+I5MwXhoRHC7btbstH0QpQgjSRf6Q+sYOwWWhCoKwnAb3eaGXO0N8RY3dgtJDlPI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+G0ALffRk0EaxxsRe6RJvJzuMrnhMvEchgW85BGd+U5NY6/P8L
 tObxEn++xsDZLhWMsHw4A5W7qiwiyhMdrbswi3uZNC/9/6ZRfUoO7kPsXwuErZ5LuauwdmAoU8I
 lhxkzrzNYdQ==
X-Gm-Gg: AYBFou2Enz7TrsplM95vWCb36hhdK6ThzbxptOJQr2xCeQGTBZz4J2KjZgijUlonW3U
 qOnjtPCk2vUH7X6u8xWrLmzROGWz2lZ+aa91vEfgAxKhMmpSvzcXC6BCqp8mxoAenmsp4+c6qA6
 B7Pxt4vbJswgQrAczS940PDhePazQ7PttM2d66muSXpx0nuc0ov9MqCqZ1hNTQYRV/HGXX443Kk
 kUHPONYKylyY8DKrpcXBmVSKrYb/9lzsisa94rCpq0DJ7MTPbYybUDI+/NBiy5q5Nrku57sihO6
 YXO7R6NU0EqMa8dhLk0KzIE8GeUBlNqypOTzmya+snZ+V323s8bo/f2qBrbRp5Vx3jtWL4Il7hO
 /7WouixPmOTL9itZf2UkeGMYE6qIQObEc1K9XQ45mDZq/ZeKyBY5obZP82kAo3CxscemWF7fjTA
 89MeCw3kfABj1xzTPWvmDl3O775C95j8Cz7q7G19gibYa2MShmjTpNjYc969gu5yHgUZjrkWN0k
 wMVBqe+jZerRNiO8zFgL6HeVkEuaZ3PamJ3n8Rlv0JEzHXBApcyJIB4VCfb/KluvilufxkFKdSw
 sy8+yzWQNu3L4ZYg6FPgdAVo83F1QdODlyUnqn5TjUsXPsIUvOuyI9FGE45v5pzdlSu16jL+7zg
 wTah4It+squqRprBMrrPd6xTTF4n2O2pdGkVu7Wx3rL9xN/mp5cWMkLI3jq7BY+R8hlnZazocCg
 Pn1Oe+ibEBCpv6aMyLKiJSHAjccH5gxg==
X-Received: by 2002:a05:6870:2187:b0:4ad:8124:9235 with SMTP id
 586e51a60fabf-4b75bb74f0fmr150259fac.9.1794945789227; 
 Tue, 17 Nov 2026 12:03:09 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74372cb0esm248119fac.3.2026.11.17.12.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 12:03:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>, u-boot@lists.u-boot-project.org, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
In-Reply-To: <20261117-nand-fix-config-symbol-v1-1-666cc78678f7@linaro.org>
References: <20261117-nand-fix-config-symbol-v1-1-666cc78678f7@linaro.org>
Subject: Re: [PATCH RESEND] mtd: rawnand: nand_base: fix pr_warn text
Message-Id: <179494578819.2846501.9964753065919718641.b4-ty@konsulko.com>
Date: Tue, 17 Nov 2026 14:03:08 -0600
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 12:19:46 -0500, Ralph Siemsen wrote:

> The config symbol CONFIG_MTD_NAND_ECC_BCH does not exist now, and it
> also did not exist in u-boot 2014.10 when this line was added.
> 
> Change it to CONFIG_NAND_ECC_BCH.
> 
> 

Applied to u-boot/main, thanks!

[1/1] mtd: rawnand: nand_base: fix pr_warn text
      commit: b58f914d7990af4a0900754f8ace2a2e44289846
-- 
Tom


