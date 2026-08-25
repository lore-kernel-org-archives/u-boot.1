Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57753C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11F15405E6;
	Tue, 25 Aug 2026 19:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1qYZPNE18rI8; Tue, 25 Aug 2026 19:16:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787685380;
	bh=/SXPSEO+b1yPF/tnMmmQVuuewo3xDJu2xPXqdY2o6tU=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=snpXtO7gxNofHoPsH2etweXI7NqJKn7PFH+zy5MqPTA2onq7AjeNNxaoDjkoYrB/O
	 f2BiwQfKfrvpZXHSwjnVj17gQADNzChY4OKwzCc8x4jdKo978aDgJ+LhKu1YvDfW6g
	 2ZQb19eM/i77pQOtdrPJuocA2OUC2AoFyrG//0bZnD0SHo8UCqKgqWesD9+2EKV1+w
	 w7MdnrBESVyjmjs3q+HVd22I/QmrYGhaQs3+RQKsupH1WLRwZKIJHmQ9TmuCOup4+v
	 Efs5ufZRVOkuonasu/xUvG6M70UE/InwguNB1uX0DNTFqxZbrlqaZMQVrb0jOl6FNR
	 WvDyXjcJUUD6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF6FE4057A;
	Tue, 25 Aug 2026 19:16:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D460396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2D6180C48
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:16:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q8l6xSqAo1VU for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:16:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=lBqLyiTE
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1800A80C46
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:16:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19FFB413CC
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29681F00A3A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787685377;
 bh=/SXPSEO+b1yPF/tnMmmQVuuewo3xDJu2xPXqdY2o6tU=;
 h=References:In-Reply-To:From:Date:Subject:To;
 b=lBqLyiTE/CT/quYRFLB5gogsa8cVMDWRltk44RCzybYBWO92sFKFu9BM56hbv6/J7
 v4+b54Je89PyYPTgwWdIEjg8CnaEHzkWocEXyl9X9ws0WMa05jQ9rx8SZL1sWx0SN/
 h5jpt18RGLSn6J3QW49K1GqVR90P4U22I/8bLC6f0orDsoXI5k1y4oE4c1UGC4aj9+
 PiMG1zR6pXtaBRt5p6jOlQkSVzKJnEULwr3rP4HoPSz0JLWmxo6Z5dN4hny5w5YYh5
 dLDjUP2pO+12lEoW5OL5d0HRJ6S8A1fJ869A7Vcu19e7Uu8hJAGtdi59J2jnO4TRQG
 vG5jMfDP8i/Ng==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5b01cb18515so97620e87.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:16:16 -0700 (PDT)
X-Gm-Message-State: AFuF++k4ySU0PsmCn5ZHC1K1AhnkVT6kOmqkZUxGlz+I8PN5SJ/U2EwD
 i3H1q9pEDz3BvD+cSfbWIlGNSv5BooeU589+yPv6qY34O+mT6+JLkfvgQJBSCPUtvw5f8mDDNbA
 SXsDisUbEy6D7HhLacUjKOMhZOoCJpi4=
X-Received: by 2002:ac2:5b02:0:b0:5ae:bba1:f231 with SMTP id
 2adb3069b0e04-5b4a905923cmr99989e87.17.1787685375722; Tue, 25 Aug 2026
 12:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-3-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-3-61446b6c289e@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:16:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLmHOA_D06DgT9CaSy7W=Vz8y38Oy9jgyNm7CQLQbfMWBA@mail.gmail.com>
X-Gm-Features: AcwNN1XCPXIxw3bVNqBNd558mp5-_A8LbUqQtwH_UIitYV4x8ofXkpmkGk_gx3Y
Message-ID: <CAD++jLmHOA_D06DgT9CaSy7W=Vz8y38Oy9jgyNm7CQLQbfMWBA@mail.gmail.com>
Subject: Re: [PATCH v6 03/13] mmc: arm_pl180: Gate idle card clocks
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Aug 25, 2026 at 9:04=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:

> The MMC core uses mmc->clk_disable to request that the card clock is
> stopped, but the PL180 driver leaves SDI_CLKCR_CLKEN unchanged. This can
> leave inactive hosts driving their card clocks.
>
> Honor clk_disable when programming the clock control register.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

CC the MMC maintainers too. Will fix for next iteration, sorry :(

Yours,
Linus Walleij
