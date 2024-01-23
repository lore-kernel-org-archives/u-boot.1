Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3D4C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 20:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48ABD87A23;
	Tue, 23 Jan 2024 21:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r5ph+yuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D1B87BC3; Tue, 23 Jan 2024 21:53:09 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6771879FB
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 21:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NKqtBg125272;
 Tue, 23 Jan 2024 14:52:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706043175;
 bh=P16SQ3g6D7hpxRN53g02fVp/BB8oy2CU+SKEBsK3cdc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=r5ph+yuX7JkQDSK7FzXmc7uErZRVbNcFwnb1bObdf7d8nkAZSUgwTxQNy+jW0oKXc
 6Q5/2dzqaDgqQw1mSzL7PuW+yRx++oDON/cvzG1GO+AZ2reE7I1bpfAHCDQo0mRZRS
 nSNtCIJNkF2qcuhYMMbekOAlaqZV+SDtHaScsj44=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NKqtT2113447
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Jan 2024 14:52:55 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 14:52:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 14:52:55 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NKqt08074636;
 Tue, 23 Jan 2024 14:52:55 -0600
Date: Tue, 23 Jan 2024 14:52:55 -0600
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v8 12/16] arm: dts: Introduce j784s4 u-boot dts files
Message-ID: <20240123205255.i7eynu6vdpoxwybf@irregular>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-13-a-nandan@ti.com>
 <20240119191743.xtxtuhnmhw7eq662@bonus>
 <f7cd5cbe-7c14-429e-b5c1-9f994f3ea4f7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7cd5cbe-7c14-429e-b5c1-9f994f3ea4f7@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 20:28-20240123, Apurva Nandan wrote:
> 
[...]

> > in j784s4-binman.dtsi:
> > 
> > 
> >   &binman {
> >          j784s4_tiboot3_hs_fs_template: template-9 {
> > 
> > and then in sk.dtsi:
> sk.dtsi means sk-uboot.dtsi or sk-binman.dtsi?

you wont need an sk-binman.dtsi with template. sk-u-boot.dtsi and
r5-sk.dts ofcourse will instantiate the required templates!

> > &binman {
> >        ti-j784s4-hs-evm.bin {
> >           insert-template =<&j784s4_tiboot3_hs_fs_template>;
> >       };
> > };
> > 
> > This allows boards to readily include the template for the binaries of
> > choice and generate just relevant output. Wont it save much confusion?
> > 
> > [...]
> It is still little unclear what is the full thing that you are recommending
> to implement here.
> From what I understood, is it as follows?
> 
> - Three binman files will be there: j784s4-binman.dtsi (soc binman),
> j784s4-evm-binman.dtsi and am69-sk-binman.dtsi (board binman)

Nope. just j784s4-binman.dtsi with bin file templates for different kinds
of devices.

> - j784s4-binman.dtsi will be a SoC binman, and will have only templates for
> all tiboot3 gp, hs, hsfs, and tispl/uboot

tiboot3.bin is a an example, but you should do templates for other files
(tispl, u-boot.img... )as well on similar lines. So all a board file
ideally should instantiate is device types it wants and overrides of
dtbs it needs.

> - The board binman files will include these templates and update the dtb
> files in them.

Correct.

> - Final board.dts will use the correct board-binman.dtsi files

if the templates are abstract enough, the additional code will be so
minimal that we wont need a board-binman.dtsi - just u-boot.dtsi and
r5.dtsi can include the relevant templates.

Hope this helps.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
