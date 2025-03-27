Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9605AC36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 13:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA78E81951;
	Thu, 27 Mar 2025 14:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G9ITttNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C92381A0C; Thu, 27 Mar 2025 14:31:34 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09CFF806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 14:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5499d2134e8so1091752e87.0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743082291; x=1743687091; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02/F1o9kQqLWiRaJ7aGgU0aLWdPYtvdclntzWKkWyOI=;
 b=G9ITttNRDiMmXIebWJx+WApLkV9pt8slimiM6lrZhvWHD9RlNOPjReqDIzL8V0en0r
 TGewmeHecJorOnIuNhIIIl1Ik6u1BCVasoBleXLhjI7/yO+2RbDVNuyfyz75M/dphv9y
 p27gro2KKOgWaKV9Y5P4w099DFBU7K7KM7uXqWJ3HeD9J1Mj2CZ4QHOJRKgloVYFfhal
 EROQQLWn1uP5UazKGVoOwI5qfd8mFaygh5hHrDC9R0Zj8iipcPnjGoUtlwklMNbOj0RF
 wfwvtV34kWcb12h97GuDV1m6a0tcp1btiCEDr0dtboD+wMOcUMoHG9HVR+zVxCrczA2K
 OFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743082291; x=1743687091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02/F1o9kQqLWiRaJ7aGgU0aLWdPYtvdclntzWKkWyOI=;
 b=L43MXQfEX8m+WlGBRB8iXtqOqsG3oaBBnHBNXqMq8cBBxhN7f31HsuM8kN3BOv2RbW
 4O3bgOe6GMTg3h6B9AJTtmOJSLX4J+dT6peCdmDYY5w/4gXEZKnFtZ0HSQz89x7ER2/j
 /shoaLiUIouht/zsrW4YKH7uPDfgFJLXKIfgyTEsmKpznmKsPoTpTA0JwjYht0V4tj3l
 YuJgcSotJ4F/nEHQ0ZCWFOF0bPdOomPWpHVUpbsfen+f5P6yjbmedTbEefPygYBXs6TH
 t07pa1nZm0R7k+PuId6k6RL9gtHK6vi+RPpRlSgZPJb56AfFDFc3Qma+iAxhjbTUz2Pq
 zfpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpkQPz0PMdWWf+URG5lj7f5DXVlh3dw8+dHTjHe5qbGlUZUBHibcktd6YMeM/W/K8uvHnxMtk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7COBEHNSRJi219mwouSq1S6wUBAsHZs3n0s8Nhs1QfDLj7lIi
 aDY2IlAlA7ipDFL/gFq0z6ZyW0x1z40CLvareNNLaxyzdt9xfJGTAi/30CDH1b18ri6XtzW9ZnH
 1fCVrlKkyur+gT0oknj3fQkP1nOg=
X-Gm-Gg: ASbGncttUGHADHqaHzU7wqzUJhGTpzFpbrl3gWtlFgxPQ1cNPKR+EErytTM9woV13Vj
 BhE9GKQp7bsUUlrA7eZwumzL7LMyv29L10DoDNcD1sT4+4WYsb1suJA1o/+JgzjDzEFeR3xZMlA
 kWZpfzz1WsnHgDtgEH0yLKldWd9ZFvHjxvbFFwR4ZT6VQJkjegDQZEsNOn
X-Google-Smtp-Source: AGHT+IHYg/RXfmzBEgFdin5PLHs/IrgPA6jf5hPfOWXENpGKlCgBvkSnTvQe/q8PlW+lh8s9L5EFMPSbG2qlUvPIhDc=
X-Received: by 2002:a05:6512:3b06:b0:549:43f2:8e53 with SMTP id
 2adb3069b0e04-54b011d7e08mr1401605e87.20.1743082290936; Thu, 27 Mar 2025
 06:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAPVz0n01g9JghOb1JCPg1sCwOf-w0AcjMZRngGZbAK_C_VhGcA@mail.gmail.com>
 <CAOMZO5BMZi3adJCcxVq3-04YY8yAAVqkdcy8Q1tMzMsK+W0rEA@mail.gmail.com>
 <87pli3q1j9.fsf@bootlin.com>
In-Reply-To: <87pli3q1j9.fsf@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Mar 2025 10:31:18 -0300
X-Gm-Features: AQ5f1JqOGRimjsjf6s9kG5Kp73FSW3V3ZbORblShtVTYSin9G5cLxdx5TpYzNhU
Message-ID: <CAOMZO5DnfOSGg0wCZpoqw9EsyLWL-ezDshGZT1s8WuBu-K_CrQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Miquel,

On Wed, Mar 26, 2025 at 12:01=E2=80=AFPM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:

> I rebased this work on the latest next, fixed the conflicts, adapted my
> changes to use Svyatoslav's work, fixed the CI.

v5 still fails in CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25364

> Then I pushed a PR to trigger azure tests and figured out you applied mor=
e
> patches (imx8 clock related) which conflicted. So I rebased again and
> fixed the conflicts.
>
> Azure testing is failing though. I just pushed an empty branch with just
> today's 'next' and it is already failing, my series does not produce
> additional warnings as far as I can see.
>
> So I am sending a series that has been tested locally. dm unit tests
> pass, v5 is on its way.

If I remove your series, I don't see any test failure:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25365

I don't know about the Azure failure. Please work with the team and
make sure v6 passes in CI.
