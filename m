Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A46606A326
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KcZtbDIV;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=DjnT5g2a
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 343A181A5F;
	Sat, 24 Oct 2026 13:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hVTbvfnkCAae; Sat, 24 Oct 2026 13:04:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B4675812B3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847054;
	b=YTE4R0XRdZzg9ECSauamDVQZ0/+LyFmFBt/lF30z8luf3VN4StkXttlmHObgTYIACPYI
	 hSvUkIRrTTb4qvyNaZwVqGd7LaOf8OsLJcBufArySBTofgYS/U+fGhqMCOHhti3LAWpSG
	 UO5w3hPaKJTnwtVHumo2bPY5N5n6GSen1FGap29r2dXmiIoyMqdiiTkuHAl9S6PpOOX1e
	 joCB8vigZ9GEy2SZkZtpQT0YvlZpu1eEdzW+2EmJT0cibAR7J9XwUTjxdeOkeS8EbbShy
	 6mZo/mPBHlv03ktEjj893j96bbVJHeMFLItjhF1g417SkDj6SwJdOFObJh8nUOkz6EA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847054;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zg7PSDqkxX6chfU6Sp8pMMLExpYxePXCOgi4vxyF+Wo=;
	b=k0KBlIocsi7/ME9pQ3xSlO1sK48nr/F6hEMyUPruQeE6D9fhLxuWYv35ab6fnmQf6FPf
	 PeyRglxNKI83FeSNryQ8Xvf9taSksfl7m/2HJTPgb1VfwIfy6YvD+qPIoSecKl+MSTnEI
	 CVlk+ya9CgLJ7+OmQQzJq6+rWKxCM9l/Q7eNJOuQcwC4XsC50RAcGsPlzswzB2UniErHd
	 cG/LznTLreEtuTmc2Egh8k+ypLKP3k21dBYzzdVryp7sp3mmE0UIsJ92ha9VOd3W/X6sG
	 NiMNXU6AHx0ZEkCVxsW9q8f/DUAaKSYXxK1MPL123qvMqhOe5vUgQlmyIxeoMoJPtHw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847054;
	bh=zg7PSDqkxX6chfU6Sp8pMMLExpYxePXCOgi4vxyF+Wo=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KcZtbDIVHSB1ujiT0W+xSC0gAlgg5Ydu3EkcZY39NwA/np5I/LO3iVToH8A1+DYWr
	 QnlyPWgMlrPHC7RHREAYwEn8HW5zPRK7FUefbySeQ0Uy4dvOg8FVvmkaveAMouIMx7
	 g18ebBnOV5hb140v6aZ8tWKdSROlnDq/mppTmXERSbSztUfTt/otUnDMYmlmrXojv7
	 yVE9yLVNYwZWVqX+TEsmofPA+5j0ewyQYWkJ/fNJp+75nNiI0h1QMfztpXBTenOurj
	 Ojg5BumU9/PfiMG1tHjsL+QLwJiXB9aXQWQubL1BL6Ik9qcaCSNbFeUFJCjh2+W6IM
	 ZYcwlEPgPqZzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4675812B3;
	Sat, 24 Oct 2026 13:04:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BEC83D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11BDA40A84
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:11:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qbJX8dAgb-Pb for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 12:11:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2FC5940A04
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.103
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792843880;
 b=pkaOp/ttN6qhEX0unGNuryNgJebgFuE1U9aOIBrbPUXhPleCIUjVF7wQG2Tn6RNKTptB
 HH8HW6F/nI9niYi9PGYapG66TaV7IezhB2Lbg5omepMEAWUxJg6ibqSFkQgHjssLLvgco
 SBreB7XO14bp1VKvsfi4fm5czBj2hdMB48k7/idQRgO39s3FLNVLodgmIZM1u6u0QRg+7
 4Q1jdLCQhegzdCOeFoWl3Jip2PpXvUsGyd5Q58+dPGS1x1jiZz+nJGZxOyNJgOuf/Ex65
 eLP7M6RZe3veeW3FP34QsKI7Nk3z7GvRiztZ5E5l5hKZKgr0Maxi2xMxGRByAdhILcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792843880;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=zg7PSDqkxX6chfU6Sp8pMMLExpYxePXCOgi4vxyF+Wo=;
 b=DlmEa1FlJaJNNh48wC+JKxzf8RczWme7X5Xq+7XVKRsBeNN/e6mj7D52JUm//OhiBMs/
 lKU8rcyjrGH+ibNwue+bRKJPFbDcty2RBgn3zT99GmG20Ie1p1keKsblwSSt5Rug2YgFv
 ZNY1yNHd/KD6op1EkMt7d4zHvWLkFzkkWqIp8CNeAD+3KuUbKTktn5Fs8cerMQvF2yQyC
 x71EwfJ6iYcc0HKwzjoxMsrq0EsFvdqYrLWpBQt5QzPdAyvF4K6UOXZhjMG0OmWoFqurb
 oVJKRB6+cUHxz/qJIJr03W6HlHxmDMXBr/+0FonWamjt8onLzdi2p/KAt1thN56GLsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=proton.me;
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=DjnT5g2a; 
 arc=none smtp.remote-ip=109.224.244.103
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.103;
 helo=mail-244103.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=DjnT5g2a
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FC5940A04
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1792843787; x=1793102987;
 bh=zg7PSDqkxX6chfU6Sp8pMMLExpYxePXCOgi4vxyF+Wo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=DjnT5g2ax3N9nIwVCYH1p1ceIy7MNH4hN44+YARU5SVBN1ue+z7BCt0FROrNfbpOB
 ZiKySmArlTZev26i+AaI3pAXsrrHr+whfFCBJ4BBocD+c3MTtE5VDGR5nFsUShTl0T
 QxRzmlfEdX5SXR3xSF4CJNHjsZ5qrigk4VFHGm/E/Qr3F+GF/KaYnhaCAapV+dAt4i
 0EdL1R9OzlMpijMYt32NiWuAGCX5uJ/5ifOPHHUddOm68TT4/QWDm7qej7IF7p1/zb
 Q6IXx2Hj3gIf1jWroFueFZHZfMz+gbpCnepKg9oQWhnEA7e4PsL4/zH3De7UqdK2pj
 Wc9vfFlzHbEKw==
Date: Sat, 24 Oct 2026 12:09:40 +0000
To: Simon Glass <sjg@chromium.org>
From: Cole Munz <Munzzyy1@proton.me>
Cc: alchark@flipper.net, u-boot@lists.u-boot-project.org,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Francesco Valla <francesco@valla.it>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>,
 =?utf-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 Petr Hodina <petr.hodina@protonmail.com>, Bruno
 Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH v3 14/23] test: spl: Cover FIT image decompression with
 zstd
Message-ID: <20261024120915.1214685-1-Munzzyy1@proton.me>
In-Reply-To: <CAFLszTjoS+fVCfFknH7hpmRjgUUJ7O7aYSPgYJa218tYEbOS3Q@mail.gmail.com>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-14-6647aa23ade5@flipper.net>
 <CAFLszTjoS+fVCfFknH7hpmRjgUUJ7O7aYSPgYJa218tYEbOS3Q@mail.gmail.com>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 2a36cd85c62a1e04bdff39ca20355eea4163bb22
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 at 00:00, Simon Glass <sjg@chromium.org> wrote:
> I'm not sure what the last sentence means. Before this patch the seed
> is the literal 'lzma', and it is this patch which changes it to the
> compression's short name. Please can you reword or drop it?

Thanks Simon. I will drop that sentence. The rest makes sense to me as well=
.

Alexey, do you want to fold these into v4 yourself? If not I can send you a=
 reworked 14/23 on top of your branch.

Regards,
Cole

