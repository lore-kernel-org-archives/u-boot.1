Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33277C982C1
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 17:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D824F605E1;
	Wed, 16 Sep 2026 17:02:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ykUtJgHyw3Co; Wed, 16 Sep 2026 17:02:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3587B6075A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789578123;
	b=nsp2o6IR3xL1yq5CHki9kHujy/sN+BP9vQSa8JgC7juoCG+hgBoLyFpzV9Mt93iNDb8q
	 wJhZIft8iib5RQZBYZdvVG2YLfSgz8GLvCpPSzGQ5kB0643ipD+7HilCtuXa4DFrQv2SS
	 p0Rn9qLmR6vAiZQYf7B6rN8ALLuPUZjxFUB8oGY8HGjsBzBMEhWYq4mUfUZNFvstUbOOz
	 7c+ZfkE2DOGigH+Ju77oTuYRQpmrFrMwo5M2vDacafsnsPJRc9DXhzfFr9ucegC4WsNJ9
	 scddpkzA3ZM9JyTNOUVZeGwR0k3EU4FSg/ZHXwipOoGEc0+NNOnCP4O3vQez6G3uOhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789578123;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=akhAOr8zPJm72DY0Q4AlGZhc7RDdrnRRcTFJl6t/jsI=;
	b=HKffAYs/kDoMESrFlRcLMur4hvo2PniFuZRjUT7lGMUlh8hWbtv9L9D8ZCTnIUNA8BIC
	 TLLKleSsMuGNaQKXWb0Per66GpRL97PierTu4vTZG1qzI8h3YKBFRnbFK9d9LYvf3mlH9
	 jGCOqPgjBnAWn65SfhG3MxmPLzPyYAieo73YHzzMPYgI/3lIwoMt7gUNUBPjBQG/pDjrM
	 B+fC5Reyrcp4WuO4lAKFZhPNV22K0r+eMOscBpEcchZg76dCRBq1UipE5mttSJfIR/9uZ
	 wJG5IwHmH5/W/ZO0fyvo9HJEU3YQynbCn8lvXl0ow3pt1T3zw2Z5ggL1POaI6HoZF7A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789578123;
	bh=akhAOr8zPJm72DY0Q4AlGZhc7RDdrnRRcTFJl6t/jsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n97Oiem5cVP8gC9/LXJlON1PhvcPXOimbO9BYl5wudFJXfhRDnr+jXStDI7Fd4fKq
	 /RuDjtgnWeaGxgQwm7G7lcprSi6G5n3fUxyd8xg4Ekrrm+sb+4GVMmSAwgTVRYt2Ko
	 d2FlHC1IGdV/DJkVCOdKLSoyXQpKKuyK/QI7JvNcopH1Nz9ZDbfTM87h1kjImUY/JK
	 7eAZhqZuaAXRoGh0qMFx+Cxt6nohssNxzLnlr5Wg9ie7JXie6BAXf8G4nvg23vL9jU
	 sC5H0r0uP8vuCiLKfRH0yH4RARU9Dnc24l8DfHWohmlZLhLWb9T0Damw40EV/9DS6i
	 zaj/baRtRvnpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3587B6075A;
	Wed, 16 Sep 2026 17:02:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A45724D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F48C406A0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJGELs0YDCww for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 17:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 98BB340640
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789578119;
 b=nykkQL+G67DiiZI6NyL6DJ6QoU4YCCZFnOQN8e1os7hPenQnrRFbjPCwGtxQ356+lHAf
 VGAGmSELnqNW1/fnuZI3Z1b7FkoRNHpd5IJCZpkZhHpRa/7iLADvJO6RZSBix5No8N4lY
 pGQ1YU28NRpJDjC/SmtcnlOq3IIaAwVjypND9NJkThtjnG8fBwZ1Run6mhYKTzZ/xAkNC
 qywAP29BVuC0ulRYciIvidGDKgZR+5APGgbydr88Z6/KC2akDT1DU7LNXsUuWdvryiTsV
 cj0fOp3MdPMMQjNTHqWjTg2FItSUttZNFJi/yCWyqRJUBSJvSMj61GlkznUwt9wjzDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789578119;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=akhAOr8zPJm72DY0Q4AlGZhc7RDdrnRRcTFJl6t/jsI=;
 b=JK3yRPGuXuwjxU4p1LPeNHthY41SYXoRsiSX4D2C1b78PoVn0wqr1GvudxKpLFqa/jHH
 xwEp6HpmEwpyL50mwyDduiU1BshEkmXYxYhyfbNEs2I5yMtPl747mO9VKBiJthNy6RTJc
 vv5iYtZw8F07Gj3L3LFLhG8Pugw/YzNNchiHHHRHjaaBgl97H6juY6X/OO4YuweknS8Mv
 NasROdreGiQnUKFpVq4+YToFKVWk6JKtBgrXBvWQfjYC0kYK6bXHswlSwyf9xGNMSynOj
 jOqVhLGQVIMT7Lt5MHg5n9V0Dsnn3WFoUCJT9KFtJn9CM4sxXtSaSPNhW5+FeGUu7PQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="J8GrHP/O"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::c;
 helo=mail-oo2-x0c.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=J8GrHP/O
Received: from mail-oo2-x0c.google.com (mail-oo2-x0c.google.com
 [IPv6:2607:f8b0:4864:31::c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98BB340640
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:01:58 +0000 (UTC)
Received: by mail-oo2-x0c.google.com with SMTP id
 46e09a7af769-7f4f0d298caso494305a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789578118; x=1790182918;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=akhAOr8zPJm72DY0Q4AlGZhc7RDdrnRRcTFJl6t/jsI=;
 b=J8GrHP/OwJ5KQl5R4vy2blWU7usKjYpPh/nkpRJoInyQbqzA1MqlbtkBQpMJWIhhR5
 oTDM1QvtZW9vO6jWhJGNmLpLuk297edLmbslOHky9mGSgcomyAl3dE3arDFW4y35tYtq
 /Hum9InDKVklRd4E+SDohw6kyLPOvaKG4+XHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789578118; x=1790182918;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=akhAOr8zPJm72DY0Q4AlGZhc7RDdrnRRcTFJl6t/jsI=;
 b=Yp4Fjdbee8o4HEydb5Sp/NiBmvVx7UbWcbNCl/P0+HvD8MZFxRsA9Na9zxJd/NNkQG
 N6Pfkk40awC5cN9iZ2cpflBTWqa3tGWAtlDP9ZNb3u1CH79Yj55Wqk2ALF4Hd8JRbj7q
 ApIuJ0gBpNHwGMpWDjMW8jTmo283LZOZg1HVvy/CdAhAWm+owIRoAzSAnrd9lmCqHKG1
 A8AcQyzluMqdSPh5kEQMUqIgzX6XZuKGoxJJFdD1RHNYd7UHIDhJ2sZbUDzpEkSDbbEx
 oaP0oY0Yj8wY0iJ1vBRBLtakQ9z2mVMg1eee23nNpAYJgFCeIRUEGeTECipZL4wS0o5R
 8NLQ==
X-Gm-Message-State: AFuF++miZ/ARxvp3Rm0oUI6TgUj/amrMeT90aLnGbZqizdtRJE+Io5N1
 6NIReuu1GuN1WKiRY2DHw5QkiYU56Jjf+4DDdddbkyT8zoNygbyG6PPPZku1hAMNR7A=
X-Gm-Gg: AYBFou0gVneEU0agQRlk/OWQxKsRmSy8H+0m7ObxPl/aDZQ1N0azS62prahuxbxktJV
 sOVAXvrEDxZvTgzgSgH7M6bcSOt0XGQMGiSAIp6GUB2oDRYTGf5ST12gHtud+q1sI+awdnqR6S+
 qxTA5h9BzcYUpOJEqnV7szPgk8TMHjALmKei6ZNjjvlnF6p3Hx7Kosjz1HVzc38DUEa5Q6lGRPd
 zS+C6IpZqakwJlqtvCKDIqaZhpEovoqW4gqsj8fKt5mraE9ph9pINJkFyxZC1VUqOijQ5WxGA6v
 l6BEpQBDaF+xlWOf48947WbwtpKGJPHht+6pA/QZb4kRZt98V/Tfvuo8O1PUEjDCqAk3nyxGZWT
 eQ8XyT8odDtf6ExOs/sZd6sFY8h9gnJn1gdiOp3MzDDL45jdwM68cby5JpSIn5Q6IX5WfQmOpFU
 nJ+Tb7vPff8Ej+Y5dsAasRPoWE38KHUCaD6L7jXepymeGyKaB0lV28dOPxeHB+SBAz1OUqknl+k
 fmgAaEMMP+QR3C513LMXDhEwAlOHdGSuHDQghKXf9B9JMOtJqeFtFF6Yz9eFI1tPCx/WFQL4a2r
 R660oOiw9P8T8U2dC2QT
X-Received: by 2002:a05:6830:640a:b0:80a:e14d:825e with SMTP id
 46e09a7af769-80b2f5cf4fdmr3544318a34.30.1789578117705; 
 Wed, 16 Sep 2026 10:01:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80c4669b120sm386258a34.10.2026.09.16.10.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 10:01:56 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:01:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.u-boot-project.org, Anshul Dalal <anshuld@ti.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de
Subject: Re: [PATCH v9 0/8] Improve FIT signature handling
Message-ID: <20260916170154.GA1188475@bill-the-cat>
References: <20260915125317.180911-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="llYv90PkChUE6Yj4"
Content-Disposition: inline
In-Reply-To: <20260915125317.180911-1-ludwig.nussel@siemens.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--llYv90PkChUE6Yj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 02:52:11PM +0200, Ludwig Nussel wrote:

> This patch series tries to improve dealing with FIT
> (configuration-)signatures a bit:
>   - make signatures work with QEMU. QEMU brings it's own device tree at
>     a memory address. U-Boot expects public keys in it's own DT though.
>     So merge both.
>   - (optionally) enforce signatures so we can't accidentally boot
>     unsigned fit images. Quite an easy oversight, esp when qemu
>     previously didn't even use the built in DT.
>   - make iminfo verify configuration signatures, not just image hashes
[snip]
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> branch: us-qemu-signatures9

Please make sure v10 is based on the current next branch, thanks.

--=20
Tom

--llYv90PkChUE6Yj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqrLfgAKCRAr4qD1Cr/k
CjR5AP9QoejFC6kZxurZYvL5Gy+PGotjqYc4/HDbZlpJyRQLugEA/urIEWmsufVw
BfbbwMZhTslFH/iOsYaG0K0v+YV7jws=
=KTQ8
-----END PGP SIGNATURE-----

--llYv90PkChUE6Yj4--
