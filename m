Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE992606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kiOOeFff;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHG10JuY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9C534073C;
	Tue, 20 Oct 2026 11:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1LWeLnnMyxv; Tue, 20 Oct 2026 11:48:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C8EF8406D2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792496895;
	b=a79NEK4PfzJkrzcJOEdZA+CtYbL0RXMuMEX2Vc5Uc0GpcKk7bQ0Ok8nWtfbodUfN91N7
	 p96DyL6iL16fqIWwW8R4dvTZYhBCg1MYFPS0zmpF4DeBZXKNKF8baa4hesGdNKNLlU6up
	 VRWNXxmHPuFb3VJS+O7aeXPr6IrR+QHPVnE9ZlXcaBzPkwUiI/oGAhSi9GeRQexFx5TU8
	 3FAftbA/oE7ED3zFlbFXbahHXS4oFlWt3q37h1BhHCSK3qqeoBuQu8j4J1QbR4eKt7rC6
	 2ZJVwGHeEdRyJEBq3jiH/gkZ8r4YAd+PPZckYroy/l+9SuShRI24/Pme/KNI7HDjP0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792496895;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=A6Q5vK631sxSyeGH9/kTjCcnlfDhfuVFF9R16WbnehA=;
	b=sSsTypCkrqy/cmpgXEUQwKoXwvdiCq0Vk2WgZlWz429Z9ArXC6zuWf9RCH4xo+xItzBB
	 S+1DwGtSeYAMQlEbWjgF7lgSmwPSoAbEB2wINYwEsbp/6QRENkNPuD2L9GryiaqSKy/M8
	 rSL62lwJmURzFoOliMyu3U0QpJgq7HMSQZFcfGMNih9hBz1A7PtYWhBH3hMLqkTGUJDGy
	 PJygQR5ZczTf+GJX9aqglruNakDKupMCMpn0EtDbfJ3QkCkkQyC1XuqW/2Nl2YqZQf3XM
	 V+MUVDdu4la6xv41XP4xgpAZjpJSz4dZSpyFazgcWyFSJvZPfaHmQmCWgFMf+EnCkew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792496894;
	bh=A6Q5vK631sxSyeGH9/kTjCcnlfDhfuVFF9R16WbnehA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kiOOeFffLtJeWLrGCxethGQ+P+B07Z4HEOyaFX2qlz7vNmzL0JfYk5WYUeZvM04qo
	 Rj8uAzDhueyBc5JYPgrGYTiCCroWM+0edpQqJjcGLcSmjpKlwptoRbE1uIhsvOZP63
	 QgghtHLiUQ4f1rjoqOcqMcx4eRVIy0uShAHzmpKtJqjxfSuVt2GeQt8AoFmlotHFI/
	 AksKiT5e7z5Zqr7UAiJoArX2oFcZMn5xMzHUIEx49f2r9JCx35RFPXz5fH1SEzkcjU
	 F2pjL0nakaq0AmqYogT/rGfJZV97tjhaD4tu7TzXdf82+7j3x8vfy7do2qhz7omJGs
	 GqB6+uoXO+T3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8EF8406D2;
	Tue, 20 Oct 2026 11:48:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 96E6D1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88B63400A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jsXBg7eKjf-Q for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 11:48:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CE5D14008E
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792496891;
 b=f7ly9mPEMFhHb5ZHK1O49/q5Gj3xkMt7kdBfGHlrK/6LCW52aYppuy1IrsDtM1FE0XoG
 cNtMlFrQsynXkcl9CfOag+uwN5LJKn7mTs0UzlICGOa0brxISJFp3Sq62RNkGO3dv7TiH
 AD3w63hjyyzWSUtGXF3Zmnj+blwxOvFkokAFPyU1jpMLwcOOXHkwAi8enqlvN7AH3btaf
 R/e10Vd3/jfa3cq0j/mQuvFuDJ65gThPcTO9tybeAGuyoWMtZKky0EdGhym3LqY6wmmXe
 NRvDD7EnMv7wp3bEYDQuzJ3BJNg0VBnPYWnjmtCs3DHhhOlFJ5T5HL2Kolg66QFxm9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792496891;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=A6Q5vK631sxSyeGH9/kTjCcnlfDhfuVFF9R16WbnehA=;
 b=k+NgEB4A39iP8ErYr7g5UZhIfNwsownsUrzAj2KrceRY1N1k3+K7C6jEkJV6n8DwKmdd
 fPY6a5GU/xQhEuW03sTw+HbF+WM7I9Z+BNWSQ0U4wIF/EXuyzFHPKmqWXItdBPfVNhdoM
 Hugw75Z5+YL0wRkjy6brnVRNvH0f92EsbyElmXWi9jGciyJf6QP5dg91idl1xld0AXjlJ
 ZxMjEMdnY06Bd/I2AUVsv0lPg8gDT41dln+SqTHssDY7HCQ2Mhj9It+LQ8OtX050MFAtq
 OqHJI2elGK/2U/ZfEiP1i/M4woHBxImWUHeaXJSoql1mjUNnOLkXfKQRlOw2B5zxS6A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cHG10JuY; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cHG10JuY
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE5D14008E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:48:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5148D416AA;
 Tue, 20 Oct 2026 11:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DB81F000C4;
 Tue, 20 Oct 2026 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792496890;
 bh=A6Q5vK631sxSyeGH9/kTjCcnlfDhfuVFF9R16WbnehA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=cHG10JuY0mFReZ+TKpH4QjBSHlv7/50UKnaIM+24kX5hLQlx0OtxphkDq2vhAVF2w
 QqCOh/ciPNKOeqAFYKaA+OUkoPvzQybjL797BvbKkALmRwlPj/Ctr14yIMw8kqumlE
 hUfjcSy4zkdnRPBeUC7NUtDg32gEQjA7N2RPSHEd9cYoGQL0T2fq7FjV6tNYmmcsTr
 QfiS2zq8MhbyE1KdzAMzS5o27/DA/sMnqNO4x4/5z9QLi0pdOCX/2nmchGfGL52BCN
 LwR0O9fdlToDEe2H9li6S9u5qgB2zmvnwZl3m5GgFMLp+Y3i6VUeRIlQiwGmQhnweT
 KO6jHeZj41xBQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260929-ums_increase_ctrl-c_responsiveness-v2-1-ec4220786c81@foss.st.com>
References: <20260929-ums_increase_ctrl-c_responsiveness-v2-1-ec4220786c81@foss.st.com>
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Optimize CTRL-C
 responsiveness
Message-Id: <179249688801.2653568.3286335798543678014.b4-ty@b4>
Date: Tue, 20 Oct 2026 13:48:08 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 29 Sep 2026 15:33:55 +0200, Patrice Chotard wrote:
> On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
> it may take a while to get the control back on the console,
> sometimes around 1 second.
> 
> By removing the if (k == 10) test, it increases the CTRL+C responsiveness
> (around 28 ms between 2 ctrl_c() calls) and UMS throughthput is not
> impacted.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: f_mass_storage: Optimize CTRL-C responsiveness
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/f1364f69907148907b6947e40f8b045a1105ddc5

--
Mattijs
