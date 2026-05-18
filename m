Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03242CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 15:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4846E83FEE;
	Mon, 18 May 2026 17:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aCqmLf8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9890C84119; Mon, 18 May 2026 17:51:50 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B19F183EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 17:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5a8891f0c88so1562518e87.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 08:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779119508; cv=none;
 d=google.com; s=arc-20240605;
 b=h0lzcVEqkHwDHpbHo+tSBz2WnJlmH+GaR6x32SjTLdvUbHUniE+NI8zN0roIUFoz6Y
 qQ8ttK6ZZlaJpgCrpVasFm/TD0qCUyhTBDFZmoHDj7uLJ8hA0aKQacSnocPYcae2bsQ7
 widixBVtkYSbK1XpLbiad7EfbIYgxFnX/bssZ9KcASeVp1fVYPSfZfKASt+m1Uhjov20
 7RoacSYa0ffY4VCC3wNwRQ9KOAF5qWPfPxusdHikNx+g5+Dd5D/lPG23chssah/OZM9Q
 amZpkKRH8twuZBeLa3w/xi68yG21L0HlcucZFF3m8fD0SEzfkcXQg6lGOV3G3OSqgzyo
 p30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h0vekyeGX/Uw/oobptPWse0kPrI4vGTdT++HXLOYtG0=;
 fh=PWqItKhCAfofNd9S16OdMqs7u2GPRu4Jq2cwanOwYtw=;
 b=Bi5scoo38Ei41mt9xu3AhSyxM8TLGuvI9oMtfslDSeJVzDk/rltCi1qNmVxwVDRYRG
 JkpiWSvRDZt3P7ZmXgrbVHWiuz5nl3KVjmAPachMe2Ubnp3o16MPVPUSMmtaKvhSB9kQ
 F8QEGNCUfC5hpCuv62oMlOmtweATP8w8D36DAk4iOaK9jQAiGab7RXZVcYrlCY1uksDf
 +kcPusKKzl7dnfC14rQ2qA20xu6vPPKHnL+amtGKrqadnhHb44tbTHA+ACerU7/Ri+QC
 Pv6NS0XQyqBSX3xXJ7O0CFA5//ZAkoGd6JomOygNwP6cBow7k5mzOEN4tQ6niMjGqjs3
 2MAA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779119508; x=1779724308; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0vekyeGX/Uw/oobptPWse0kPrI4vGTdT++HXLOYtG0=;
 b=aCqmLf8mJjjXptaIXMbG6725yzsMlq7wVnDpY9KtX514BmrA+B/bLPyMxDRBeViPo5
 7TRpap8oqWQhk6SJXT4I9oseKosR/sLQ3HCA+8MtdOAY0lgDCZTTYE+hizLvQZjz5l/l
 jMZhK7ZBFSW711BGRu7V6T6dfaQ8gRYc/3022px0LqxehE0/YO3uYptFyhkJDaoo7O/j
 FadsGPWw5qYz73cIlJhjya5vPkpqsyY4KAIRYINvcm3I+gjJodF3YmF8hOkhg1GTme4+
 uXLJC+vYWFS+uGT4fisgKPlxXTA8tNWvMhaNUdhzVBSx29BuOy7oftUg/Q+ot+41sBkZ
 O7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779119508; x=1779724308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h0vekyeGX/Uw/oobptPWse0kPrI4vGTdT++HXLOYtG0=;
 b=YqxGEjt26wNPdPb7DlcxCAyafMISlmtX+WqWk6RsqCQM8Yl9PmasJSvgm1JaTTyrIL
 F2bh2PozBMIcSlajCG3HArMB/1GOloMGKWoSNbOTO5Tr6ILVxCpOXBYfZcrj2N36RUUj
 CJpqxv4P6f1ogfzWdMtQfAdU+5R5fNX24F9XUDzPo3i5v5d94uisEw1gqp4/QLlp32O5
 FK/HqLsvHxjv8lN7BCsOr2u/5F7lrWWKDtuRxh3Z67kofrI6kK/uP/ABNyjMvvVLHFrh
 p0LsjsScQMSI1mQl17bWCssLsJk9zGBTldG7dMk1+c4ZbkV6R6ICb1h4WiiXZzeqfj86
 5peg==
X-Gm-Message-State: AOJu0Yz+jsjILVwmd+ubzx0Kp3vcatxOQXQmRDRvG1KAr4xqCXlba4RG
 QBiP9FrECqdPtKWIo5WM6bbISUGp3JO+eDr9G3BtoCsT7PD6rqjU8eN0VzluDAzvQiDgJchCt1Q
 Pq+x+qOx7GjgTHKl2OuTjLEUvzusD8SI=
X-Gm-Gg: Acq92OGp33PC7a6xqx9DpmOfDZABfPTHSWFk8DA4GXK1rYFwO3vmdP4HIZzioLOMFCn
 rLmBbj6dQhGWmOyUGonY/D+hQ/Oi5l5CSPSc48unDRWZNi+nudXgkFyqRq4l1YH/aQbQ9yu6jlJ
 7Q/9U1hp+w7HqLZObOTFtXeof6QdmkMqFEvz/4OHmSq9CMtr3jG63qL+a+8NRa0YhpWgw0qnsBg
 dq0QdLZeIQgElPlfgPka5xHbmJCSOGmwas9HK4Dwmx1r13i+ErlV8ZC0+FKuv4bgIXPpTviMKYR
 Ibs/KPIpb89VdLqhCrL7F2UDI4uUtJcySLnlB9kDWorDEBUZZyCb1y8u2kdpSIO8L5nI+3w5
X-Received: by 2002:a05:6512:39c2:b0:5a8:ee4c:8ae2 with SMTP id
 2adb3069b0e04-5aa0e73a2d6mr4330122e87.30.1779119507233; Mon, 18 May 2026
 08:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-4-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-4-c01ec2ff3886@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 18 May 2026 12:51:35 -0300
X-Gm-Features: AVHnY4IEoBb61IE5v5moZ-0CoL7K5ut95qZZv_owggr3-3goMKTcnoW5KJ24Xkk
Message-ID: <CAOMZO5DN9xpWo8BD5gS4Q=VoqGJrTrGBiYoqKdoSByim7KsJCQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] Revert "drivers: smem: sandbox"
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Heiko Schocher <hs@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
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

On Mon, May 4, 2026 at 4:07=E2=80=AFPM Casey Connolly <casey.connolly@linar=
o.org> wrote:
>
> This reverts commit 7fd7e2cf339ea2ec570f6dae1cdfaf8e066eb4af.

It would be helpful to have an explanation here for why the revert is
being made.
