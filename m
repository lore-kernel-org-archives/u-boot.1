Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42345606A31D
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oyEIIqSH;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aEag6/Vj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA554816FD;
	Sat, 24 Oct 2026 13:03:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eesmp0JBd2fz; Sat, 24 Oct 2026 13:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 339DF8168F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847023;
	b=UXCNhdpUD05Q49BZ2Q1uyvo90XCHk0/e4JjB2BAeFn7YOKlr6qJ19nImoii9VP90wpqu
	 mF6pwUyDsNW66Qs+pphLUye3+OMwfVPH7y6tZp2QX41uZ7sXjYtX7tCwx8VGKbKyDKtZc
	 01edIFKdfI277cmNh7A23W1dMyzL0x2+qT8AB3afLSQLoX1YrAHEvMii/TjLEEta6XjNf
	 bC3T+E47RYMmUy3fuB2aumMkTW8PGbmmCXTtb3F+bArNl+wHuUfzscr6nIAfXB32P78KS
	 fNY5tJXF9/cFfALQwKJkrAwgX2qJjchmbE/9cLc6gvtBHdfeFxcHkkaYLuprwq98Ntw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AstFYWnL6iMd3tZDm5AqMI1bX54D9vH2/9m0JQ9L+DA=;
	b=G7YvuvvqT7DisP/iuJGaNZIj0EJBRjTpa284uF4rgdrUxwnokzWFCuP8syVh/4uEIOss
	 r9h9aXnOjMU5/flYQjSsN/1N9HXQP4KIKHH8AxazFJ0UzyPuKYe0M0eKd3/7s/6d0xxRH
	 JgjauVqz8L5YITt30ciiEbgVKgqEiknIaEN1nXmSGMNZeeT8/7g3Jdy0G/szpOLOnYRJT
	 /nMhklkyu0U24z41deZgFMavaVrxUwZ5lnAeNXg31SmKhcg6L7yfcXFQPGcuw5dVDrMkC
	 KUgAf2JgU5jquuvgeB7a/xrrU4X7/9hONgzHyiWSoFsJzUKnyltq+neBVrYfRl8/0yw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="aEag6/Vj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847023;
	bh=AstFYWnL6iMd3tZDm5AqMI1bX54D9vH2/9m0JQ9L+DA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oyEIIqSHjF/N4ooIfMLYOIjcYisHtrsiYJ71vQN4yf9H0k4c8ZI/RyDSvcBAm/2Wz
	 o7YdfPZykuLLnOjsY0TVZv+Fiac9WI5EIIVzmgplsa4AXLPQHVE+5twKMNxDwvcVWJ
	 9wdc6obImijSGyD0hT/z7FCyVG19Z3HVI0RwglUENhgHhg6ibUj7gRkeeXMKW4c+jD
	 TyNovdWp+7aIv6u1dgX6k1Na2K3KufZcg/8wmnDPFIDFzVPXrZQKlGdzdPOfpkI425
	 ZCTGGYB7S56T/IeYeuXOxGt0/O8WTHarRA3vNvmE2Gga+0GW20sNxpqtdX1JU5DUkH
	 s0wFTpuLop8/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 339DF8168F;
	Sat, 24 Oct 2026 13:03:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 841E02C7
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A8DA8127F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9Xx62xIdb7F for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 823388162E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825228;
 b=cgjr8Ihnjo+YN4HouwsEg7W+oePTg+Fz9ojGwWYN0QXfePhBuVD1UirCMyCrmQkcxqbZ
 jwgnl4NobzTVrSMuJuGMaN+JvKQ6O/1P4mVAYPQs5RD864xJTGxXK8JAQiQwk4oWMCzPd
 kmEr7KpKpvlDCnviDcn7w7AMdFihJivvgKa9DlXwjxNi3XgnviufqHa844Rqsmqeb1jDW
 MvrAvhTKtPRWVKgGqo4/Wdwryz7hN7/akCcN7UizBD0uy1Yrmcnh8uJHJoFo6yMM6oSmY
 uDRDXm5dBXVR9vJGYfh7qVlm9cL1lpkgG25TX/fK6Y7H0hMpDyn32De+AGDBrSmT5hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825228;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=AstFYWnL6iMd3tZDm5AqMI1bX54D9vH2/9m0JQ9L+DA=;
 b=lo3cZzAWB7K5FlRH4ckBNGcZ/xdUanE4jY0lFTuN3cX6S4TVV8gQLkDo6nP04GiBvRmH
 N8CyyoJzXDMl2uAY1o3xhKMPEv0SSyuSXAC+bbhNfyW8tUL4l/VIKGF3cWz13rE9jLo8u
 4qWcPqcrtsq/Yl4lZCkg66I7qx6LoIrXjL/0sZh9+rD880RxBOrUOb9+9jkmKWIrgFdsX
 PJG8UFOWckzYfZwDw6I2YwHpo0NShzm5hQlGKnaekGDr88fHSA0HFQN4I7CQYQ3J2ig8S
 dv+7EyWaTGtMNd73/zhZRTqW2B/F5sGt7flXkXYPlg28NYT7yDTBQXufwYwzVS9ztCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="aEag6/Vj"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=aEag6/Vj
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 823388162E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:27 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so2949281a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825226; cv=none;
 d=google.com; s=arc-20260327;
 b=A+7PVlpNEYkQsg0MHqEJh7bxZJr09rxpW9iBAAV1FwMjffbqQaPLzefoCdXQqqB9vh
 sBUk8fRJpe1xqpjDTyUkdZ51KStCMOapAm2mJLsgMM9l24Y32BrJ9PQVtWMeccP/WkJd
 Ylu6naC1+0L7Zg9EJScgFO0g2CAwSG57xDIhr5DRoylC76qg5CK3MOoMBACp8bpZA0Yk
 1AfQxKV6fY34KiMIBQZRlaoaqbMgHp2rtpPSeaTZjpuO6sW5BII7TmS35xBo/pjV+KBy
 +S83lUwNmzXmbIyzuaOaHUa0YuMO8BzLL7le+1SAjpwyyc/tvoomUIgVzW4+7hUyKGQA
 oQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=AstFYWnL6iMd3tZDm5AqMI1bX54D9vH2/9m0JQ9L+DA=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=pH9Q+pfYY5rDyr33R/GQGD+jWv1Pmy0bMbIyOJOLqzPLHVGmb31dMnv32Bb3AX34CR
 bWyXhbImQ11DbuRaJ9yLIblb9UGPXTTcuKfqhQpTH5B6MFDul1K8PeXUqQJdAwDzJcvM
 DTCNnCDl0WsvPF62agI1VMlm66LaaaHOqnoqnF3hUuNJiammhEVr0jN8zK6u6zRvlIXo
 08sxVjKS1MMtAfvLQGgsmuql+TE03CkHnDrp2mk3vNDhkmuTDrsBnhE2ckHLfQOvnDFa
 C01Y+gxreYg5onobjkNsW5fT9pjbndwQhksIXpgSv0no9EiSI6UHgWX3xcTLx/sYlDXW
 23Fw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825226; x=1793430026;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AstFYWnL6iMd3tZDm5AqMI1bX54D9vH2/9m0JQ9L+DA=;
 b=aEag6/Vj5h0JI5qgHz1XZ76YcIgVxPgCCm9VMV67p9gft0ILP8spnflLPlyR1sJKLQ
 jgvW7wnM54s8NPIQ3VdiJvpIjmXh0sKeLc48Wnmfz4iewNNz8Ycj0WUmD8BGFjpv2AJP
 g3Tol6wWicVZyCouCy55XeipMT5YUsoE9JaIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825226; x=1793430026;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AstFYWnL6iMd3tZDm5AqMI1bX54D9vH2/9m0JQ9L+DA=;
 b=aFMUXooirhabtNSt4bxy97acNHaTKAA3TbLzHivYRmQ863pIOqlkOcgbkjSfDGvdbT
 gh0NG8/rdF11RrgmDjYPMAEPwyvMKVJWVzjAJXWlIiaUC1bGMLDyNJbQ8n8nQnKGEU8r
 DtWbu87dccOjWtT5X5qZlkQYzbSAAJTMHqF9dNSIiVqC1ERNSDNwLvBp7QviykLZBNuR
 AKiR39xBox91i4g1iL2vBfnK2e7X610/LC2wFBBzPYXba8ajRSQgEDcqq/2fBF5Frzgl
 SbphN2xd/yCI55Wzh14HH7OPzTJTOa5sxlv1zX0LyF8iQxrKgXUJP82dxWgHRbjkV/+h
 0xSA==
X-Gm-Message-State: AFq9FYJOiik3ENa9YYrlb77dN0mTx1des23sNQbYsqgEHKbK65K4Fczx
 33BRa8XYfWrUnNvzM90PtxiwCkOK08hWmBlU7ZfuuY4yEeWytqbAG2K9KxF5X/gq79Iz1tnXivn
 EwUnFunYaAtlJb4JrP7DghKKIf1pIpGGYus9xLQmy
X-Gm-Gg: AYBFou3FWX1SZqtNjC1ekcd1QA9st180Y1XQVAGxBZz69PWqJ8VUAFxmwfl0tvyHrnM
 lJNcw3XS0tL6ddw6zW1MIlrseMMfltsVa3xSEfiMlNmvtvnwIJxLlJmeBudXrnanqbCWJ9tX5Rc
 F/QUbxMJ8L7ADii+APV7I4HJOWFrMbwaFRLV+o8dCNH+f289Cglq/4CMOn/Pz5xa+izLAzaFfld
 2MZXqx4WKhm8dI8/LTMZREx6EhARR9pLt3hImY6UQ3fGNh59HyRXxgh5oies9T7m+0Us7RBhuwc
 HiIrVEF8Qa/Abrh6KDjKj/fHzm7ovGgwXb4W4QO5e97FAmTsLJB7qaM1oOielRCKLG/8A/0ub61
 H123h4JU6ns3tklzq7MMvrFLKY02UemYRguE=
X-Received: by 2002:a05:6402:548e:b0:6b4:1629:b1a0 with SMTP id
 4fb4d7f45d1cf-6b442a87d1dmr1607464a12.6.1792825224166; Sat, 24 Oct 2026
 00:00:24 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:21 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 05:16:30 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-10-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-10-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:20 -0700
X-Gm-Features: AclHuK-4k35CCzW3aneJMpLdcfqJT4mGEXV0xYr8WTWZc-R83Mas1kL5TD5xcrM
Message-ID: <CAFLszTi2C3GPBnnSNhXJSw5U9NAbUH4a-D-J0h=UTpT0uHVF=g@mail.gmail.com>
Subject: Re: [PATCH v3 10/23] test: spl: Size the FIT properties for the image
 name
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> test: spl: Size the FIT properties for the image name
>
> create_fit() budgets a flat 596 bytes for the properties it writes, but
> one of them is the image name, which is named after the test and goes in
> twice. 596 bytes fit a name of up to 27 characters, which is exactly
> spl_test_image_FIT_INTERNAL, so a test with a longer name causes libfdt
> to run out of room and create_fit() to return 0. The next patches add
> names such as spl_test_nor_FIT_EXTERNAL_LZMA, at 30 characters.
>
> Budget the fixed properties and the two copies of the name separately,
> each copy padded the way libfdt pads it.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  test/image/spl_load.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
