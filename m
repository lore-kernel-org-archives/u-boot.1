Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51158CD8C88
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 05:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38B2084099;
	Sun,  7 Jun 2026 07:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="l1ot71fh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4FB083314; Sun,  7 Jun 2026 03:26:14 +0200 (CEST)
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 810D680433
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 03:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780795569; x=1781054769;
 bh=kckd55GM3tFAbXDK3fDqEW1Krz0/d+KlmXBjlOYGeJM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=l1ot71fhs7c/898hLC6dAlH5oRYuqZYERQH5QwwAk4izOIeJSAYDEXJa24yO0D0Q/
 UR5tK6SoZ1QfWP5JcTKM2uMWvcJPnL1qXwywvzm33j/JDnmqvDnXfyCPyXYbvcuhyA
 E1o1YWnDmw8ymoUovLkIKJ4tbJ3GYlhYUZEb2HiQeARUN+lTQg/mmBl0qUgwbECSSz
 RegYPcqTCmdqPkqLt+RzKcY5BDqc6WhB4bn0SiC/VBgH1RbSnsoRnbdSk+pYgZa3ce
 1Q8tWqJwp1tLmiAH3pa4FZRTYF4S/s2JQKpXLuahysgcumMMQ2sYxZdRbuxozgLAcI
 wIeyVGyZS1DGA==
Date: Sun, 07 Jun 2026 01:26:05 +0000
To: Stephan Gerhold <stephan.gerhold@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Luca Weiss
 <luca.weiss@fairphone.com>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>
Subject: Re: [PATCH RESEND 15/16] serial: msm: wait for TX empty before reinit
Message-ID: <PQylQNPSFyxQS7D0hVPC7Hcm4P4rdX5iso7HXKhX4I1A47it7YgcaV5IKHwHvbvmC0i4RrByshmkoOxZVDopPtvpRBMFr-BY6ZZXVXz9r1E=@samcday.com>
In-Reply-To: <ah1FqUGQYaS15Cad@linaro.org>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
 <20260601-qcom-armv7-v1-15-05a08d87e476@samcday.com>
 <ah1FqUGQYaS15Cad@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: ade7a9edbc2e72f956c871d52363fb659e759f20
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 07 Jun 2026 07:11:15 +0200
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

Hey Stephan,

On Monday, 1 June 2026 at 6:41 PM, Stephan Gerhold <stephan.gerhold@linaro.=
org> wrote:

> On Mon, Jun 01, 2026 at 06:12:56PM +1000, Sam Day via B4 Relay wrote:
> > From: Sam Day <me@samcday.com>
> >
> > At least on UARTDM 1.3, I was noticing the early UART debug banner
> > getting corrupted. It turns out this is because U-Boot was
> > re-initializing the UARTDM block and writing to it before it had
> > finished shifting out the FIFO from the previous bootloader. Waiting fo=
r
> > TX_EMPTY in the status register consistently fixes the issue.
> >
> > Signed-off-by: Sam Day <me@samcday.com>
> > ---
> >  drivers/serial/serial_msm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> > index 10948e2aede..db085d68a0d 100644
> > --- a/drivers/serial/serial_msm.c
> > +++ b/drivers/serial/serial_msm.c
> > @@ -351,6 +351,8 @@ static inline void _debug_uart_init(void)
> >  =09 *   - HMIBSC: GCC_BLSP1_UART1_APPS_CLK
> >  =09 */
> >  =09//apq8016_clk_init_uart(0x1800000, <uart_clk_id>);
> > +=09while (!(readl(init_serial_data.base + UARTDM_SR) & UARTDM_SR_TX_EM=
PTY))
> > +=09=09;
>=20
> I think you need to add some timeout here. There is some funky SoC where
> the UART is left in some half-disabled state and this bit will never
> become unset. Maybe it was MSM8909, I don't remember exactly. I have
> similar code in TF-A and there I had to add the timeout to prevent the
> device from getting completely stuck during boot sometimes because of
> this loop:
>=20
> https://github.com/ARM-software/arm-trusted-firmware/blob/da738d5eae93af3=
42fdc4995dd3c05acb4c9d757/plat/qti/bear/msm8916/aarch32/uartdm_console.S#L6=
8-L81

Thanks, that makes sense. v2 will bound this wait loop to 10ms.

-Sam

>=20
> Thanks,
> Stephan
> 
