Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CED8C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BCAC81F7E;
	Mon,  5 May 2025 14:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="lk6EC47p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A272482076; Mon,  5 May 2025 11:57:13 +0200 (CEST)
Received: from sonic311-50.consmr.mail.ne1.yahoo.com
 (sonic311-50.consmr.mail.ne1.yahoo.com [66.163.188.231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 286A680F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 11:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dullfire@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746439028; bh=4HB8qg9TnqLAP+dZIc814zKSimo6oOrNSXfPEwoplII=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=lk6EC47pPugMBSnjJi/M2+5TqbxAA9zrdpfCH6t1/mY1SAnYli94XnggPewFzsBVtDqlY7adiT0B8Qw7e3oPEj/aYt9IjfL6Q75I+qpFv1LZX/zzjPdHVo04c1JEEntByOMc0AchLWwbtpvAknV/K1knZFb6PyYeFm5Yd76uLkisNnIMtrhMXPF7XHUvNMyjHCOM14BDvaAt61hkapdDCoPrT0WAv9aHDBXj+rOcMStBcxVIezW/0QlQjNs01fsecIfvmx01N/cnP7DwKB4VetG/mc4RpmzmBW8kRHXzxqXPBM9K24QE4C3cNtzLcfpFF/uBlyf8uYkm+SbAh50F0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746439028; bh=SnA5iRGZgzlHAC8rIdP/bhjJsXQntmA3CE2HscUGtuI=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=heXRav9vGfeoSRLtUxVMMrAzcQ+uf7pNQZYJpIEqFMyZUnWg86yNThdAROGUDHmfT4Oxk38jbo8RaWmbmXH6MPJca2BXq2ZAqUt+32V0u9ee1rQiAhikAmCr8QUkyDXwrbnhHUgPfSfzgeZ0sWVlIXe/g8uwYTBOMo7xn1qD8A7Nb3Qr8Q0dwvxOnELpTKvb/jpR/QuKmNG8pRoN3WiSxSiCYNVuw2FS0OOULQzajg4vTxjROioCrDzEzL3ApFfzQz3hhDXQ2c/ul3sy+1UdntaYdeBklMLEgTQ8s6Dsc4c/RPXF7eq1JI0CwwMAkrOBvONcZhaRkBdx4cG1eZsDpQ==
X-YMail-OSG: ElZngnIVM1nb7GgCBR_8Rkd6IkwTspKIJgn3.faWhYc40hLCsKpqA1GWpCTco6n
 YohEfoAgAJfTsIfDLEFIt54okFxY3VKv4tptOeWVqiZlWP_fYvvVP1lwzfTk7HvQ6b2.eGrU71pI
 UBw7DpOXqoo_cUXmUhQdNVBrEnZRJ7P00j_j0CO2qWROdEHLtNXZAKTZenmQw5sFhzA6QZriQYST
 jsuo_BK05O91I8wDWfDbOk.xNRW_AjHH5JPI3yefhG8pRWJQkJdNxVgdU0bS_y2XfvRXfsaOvfAN
 5Fk8E3e7Wj5QDCgr2cLcMG1uJVmXGEMFbdMT8UghhXo34S4bfDmMXqqHc3pO74gSarDYXuCIqEOT
 VKMylVxiyoP.BNAifMm2lEu3ouYPh4pZ6WZwaOERVEJNTBsh6ImKWp7v8__qczpQGIS_WLDdP.MX
 bc7G6ra3T_g93iSyILN8upvMnE29CGcEXsZY.P6fDvaAO5hacB0hhkkxUZ86NjgPDtAc_8m7NOnI
 Jdkpanp3Qf3Xl6nvaaUsjsmtVQlAfnhS2UxP8ehkJIZbTH25Z0GEovYfUQlafLgjLJhgfTXBVmy3
 HclDEO86zc9Kw5Hu3_hW_S3LyGfcp7HU9QFVXe4oozr1cP2Lx0E.HohdyMqrZhyYdl1eTOdASbl4
 Zh4vqzMC9Wh0SldP5cLfF7KTp6XHCPjYI_eFUtZeNNLolQY1Ls7xlVmgiu3NSFccqIU6DY0wpfgB
 qNf5WEwpy7I3cpxxcPd2808QSbGwygXOMZkbLZpEKjZ0YTVrRkdmLzNV2h_HFuCIffLdHeVYGVqG
 nDenR0OjoRdwmW3el_viu88xfuC7W1ojJufGwamm3jHJQHuFmNxeVsF.9kFJxopUJSe77O15jRth
 yPNBChbF1ELg1cil8j8KroQIK1u.bcwdluLgS4dd5BPH2YFAFurj5AvfD3SqLvUrDPA4ZRAdvdHm
 a3J5iWzkkIdvdVRcL6yuS0vS9oJolreX4SwAGzqt7Rq3cc67PQMPoW5Ltu2oM65s1ruSyeMP.n1C
 U9kZxTjrtdf2F8ExsOeERvivPfeLQuXVCwVrnbWeD1QDp7OV.CLORVyeCBPWz51eZTSV3bJCSrXR
 Uk.g38NGe_iPcjEpeYBsFmbmeKxX6rtqMBfAWAh2s2_mt_6dA3CqZjVA5qPqxupXXxr7Ks9AhiNS
 23jwuZjXvLCaTn1JV66Mow6Rd21uWyDTMRZaoyr6ahcJxe6iF3aTNIZ2K1.rx6Z1MdHxL8UHohDf
 QDHxX1SjUNJIODsr2YMBoRpMdie6RHDQjm4bWak6bQZUTG7xvpW_.LYeTuAjZK0y4J7as9BCoSpl
 Mp8xuTvbxW.qbPDNEpnzGvdkOsyv08OUZVLjZzBQ4ZxGiha6vJW59DrJM5xJ0jAo4Rp43brdxFXG
 eviXK17PbG33D3ySHykwmb1WVrY9CMTIdS0apmPFQLmhvzZ3tw0YU6ZHsmgD33ra8V2LM7mUEh4g
 ko_NufX0Vh6UHHuKolzsTO6gAFxqdrpNmSaNoyRDvDxsniMonN94ROMAeQUTvwxHiWn1ELbFIXcI
 YxrbGc227jzNKIigHoc5OMraAzwpiuHPgTBiTSQso_G8Bj4uWSQfaRHM_iiDMFmDd.SvcbNTYv84
 b8TeWcVERtng.lI0mCNYpHGOpdmaRtghKCLp.lxwS7iCm6RTL4lBe9ZjYLV6c3kYcPBSzhbg1KrS
 tZEaYGOjjJXgufHxj.XV3NbRQzhpL4aEInRYWU6XL3onc2eInhVBrc.REkdN2bPPvgkzmxB7YBfj
 V_adfDAW6rVW64Z4wXCTwj_NVngt_FZdLAFcKV8Sd0qBfMM6vMG7VbXHE0aeker.Q.w2PqQ3xyTy
 1FatDns11xxgqmSK7zapj.hMcaAhTAU8gsjPyUzUxrqsqj3Dni4YWnQjLeeRg672t_SUbXwZ1Dw8
 xdup4ibzgSLFFVfroH4WHbJdiKhM94mD7GX3J2boKzgGBYjfxWWloYzVJJ2lJcL8pU.eshKcXw35
 55mYshK76n4Gqv4TxVn5ZZREDEewvWXQizDOZBlCMq3i9z_h_keR2IzI9oe1J6dsjS.pnybGWEfH
 9dSud5N50IJMDW738aK7.1TbUKOYqYnBtCDyjZQW9cdxYLAobVkUXSaeBw1VT5j7ZZlllAFPZfij
 H1m1_BMZ77JWpCjaWvoyKO1wNoGdkF7zvSJ7ldf_RaG5YRA1DltkmKlQRJNVspMw_2uq8m1ysZct
 0Iu5VKFtOADqw9sQDBF9vl6cl5np1UgJ92y8xZ12h_fAsX02io4QvI_gXqIL7RVpRBmPEZ0VVszp
 _jtE9tuP7tM67ccTGMQ95PawKwif0MZ1jEI86cg--
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 5a7dd38f-05e6-4bc8-8187-0492c2535b12
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 5 May 2025 09:57:08 +0000
Received: by hermes--production-gq1-74d64bb7d7-4jn9v (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 9e13697d57f68d6e2f15bff24b248cd1; 
 Mon, 05 May 2025 09:55:07 +0000 (UTC)
Message-ID: <865d511a-c571-4f12-8f5b-a3182f2b67d1@yahoo.com>
Date: Mon, 5 May 2025 04:55:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] spi: fspi: Add imxrt1170 device data
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 William Zhang <william.zhang@broadcom.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Haibo Chen <haibo.chen@nxp.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
References: <20250418210430.27458-1-dullfire@yahoo.com>
 <20250418210430.27458-3-dullfire@yahoo.com>
 <CAOMZO5Bfq23ocQXd5pvsHzD+dnRexW=PFunf27dwtmz2o_ov-w@mail.gmail.com>
Content-Language: en-US
From: Dullfire <dullfire@yahoo.com>
In-Reply-To: <CAOMZO5Bfq23ocQXd5pvsHzD+dnRexW=PFunf27dwtmz2o_ov-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23772
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Mailman-Approved-At: Mon, 05 May 2025 14:37:53 +0200
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



On 5/3/25 8:52 PM, Fabio Estevam wrote:
> Hi Jonathan,
> 
> On Fri, Apr 18, 2025 at 6:04 PM Jonathan Currier <dullfire@yahoo.com> wrote:
>>
>> Add the device specific driver data, the device tree entry, and the
>> clock configuration.
>>
>> Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
>> ---
>>  arch/arm/dts/imxrt1170-evk.dts              | 28 +++++++++++++++++++++
>>  arch/arm/dts/imxrt1170.dtsi                 | 13 ++++++++++
>>  drivers/clk/imx/clk-imxrt1170.c             |  9 +++++++
>>  drivers/spi/nxp_fspi.c                      | 10 ++++++++
>>  include/dt-bindings/clock/imxrt1170-clock.h |  4 ++-
> 
> Please split the devicetree parts and driver change into two separate patches.

Sure.
Should the dt-bindings include update be part of the driver changes, or the devicetree commit?
> 
>> +       clk_dm(IMXRT1170_CLK_FLEXSPI1_SEL,
>> +              imx_clk_mux("flexspi1_sel", base + (20 * 0x80), 8, 3,
>> +                          flexspi1_sels, ARRAY_SIZE(flexspi1_sels)));
>> +       clk_dm(IMXRT1170_CLK_FLEXSPI1,
>> +              imx_clk_divider("flexspi1", "flexspi1_sel",
>> +                              base + (20 * 0x80), 0, 8));
>> +
> 
> CI reported the following error:
> 
>        arm:  +   imxrt1170-evk
> +drivers/clk/imx/clk-imxrt1170.c: In function 'imxrt1170_clk_probe':
> +drivers/clk/imx/clk-imxrt1170.c:169:28: error: passing argument 1 of
> 'imx_clk_mux' from incompatible pointer type
> [-Wincompatible-pointer-types]
> +  169 |                imx_clk_mux("flexspi1_sel", base + (20 * 0x80), 8, 3,
> +      |                            ^~~~~~~~~~~~~~
> +      |                            |
> +      |                            char *
> +In file included from drivers/clk/imx/clk-imxrt1170.c:15:
> +drivers/clk/imx/clk.h:195:55: note: expected 'struct udevice *' but
> argument is of type 'char *'
> +  195 | static inline struct clk *imx_clk_mux(struct udevice *dev,
> const char *name,
> +      |                                       ~~~~~~~~~~~~~~~~^~~
> +drivers/clk/imx/clk-imxrt1170.c:169:64: error: passing argument 3 of
> 'imx_clk_mux' makes pointer from integer without a cast
> [-Wint-conversion]
> +      |                                                                ^
> +      |                                                                |
> +      |                                                                int
> +drivers/clk/imx/clk.h:196:39: note: expected 'void *' but argument is
> of type 'int'
> +  196 |                         void __iomem *reg, u8 shift, u8
> width, const char * const *parents,
> +      |                         ~~~~~~~~~~~~~~^~~
> +drivers/clk/imx/clk-imxrt1170.c:170:28: error: passing argument 5 of
> 'imx_clk_mux' makes integer from pointer without a cast
> [-Wint-conversion]
> +  170 |                            flexspi1_sels, ARRAY_SIZE(flexspi1_sels)));
> +      |                            ^~~~~~~~~~~~~
> +      |                            const char * const*
> +drivers/clk/imx/clk.h:196:57: note: expected 'u8' {aka 'unsigned
> char'} but argument is of type 'const char * const*'
> +      |                                                      ~~~^~~~~
> +In file included from include/linux/libfdt_env.h:13,
> +                 from include/linux/libfdt.h:6,
> +                 from include/fdtdec.h:17,
> +                 from include/dm/ofnode.h:11,
> +                 from include/clk.h:11,
> +                 from drivers/clk/imx/clk-imxrt1170.c:7:
> +include/linux/kernel.h:44:23: error: passing argument 6 of
> 'imx_clk_mux' makes pointer from integer without a cast
> [-Wint-conversion]
> +   44 | #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +      |                       |
> +      |                       unsigned int
> +drivers/clk/imx/clk-imxrt1170.c:170:43: note: in expansion of macro
> 'ARRAY_SIZE'
> +      |                                           ^~~~~~~~~~
> +drivers/clk/imx/clk.h:196:84: note: expected 'const char * const*'
> but argument is of type 'unsigned int'
> +      |
>  ~~~~~~~~~~~~~~~~~~~~^~~~~~~
> +drivers/clk/imx/clk-imxrt1170.c:169:16: error: too few arguments to
> function 'imx_clk_mux'
> +      |                ^~~~~~~~~~~
> +drivers/clk/imx/clk.h:195:27: note: declared here
> +      |                           ^~~~~~~~~~~
> +drivers/clk/imx/clk-imxrt1170.c:172:32: error: passing argument 1 of
> 'imx_clk_divider' from incompatible pointer type
> [-Wincompatible-pointer-types]
> +  172 |                imx_clk_divider("flexspi1", "flexspi1_sel",
> +      |                                ^~~~~~~~~~
> +      |                                |
> +      |                                char *
> +drivers/clk/imx/clk.h:142:59: note: expected 'struct udevice *' but
> argument is of type 'char *'
> +  142 | static inline struct clk *imx_clk_divider(struct udevice
> *dev, const char *name,
> +      |                                           ~~~~~~~~~~~~~~~~^~~
> +drivers/clk/imx/clk-imxrt1170.c:172:16: error: too few arguments to
> function 'imx_clk_divider'
> +      |                ^~~~~~~~~~~~~~~
> +drivers/clk/imx/clk.h:142:27: note: declared here
> +      |                           ^~~~~~~~~~~~~~~
> +make[4]: *** [scripts/Makefile.build:257:
> drivers/clk/imx/clk-imxrt1170.o] Error 1
> +make[3]: *** [scripts/Makefile.build:398: drivers/clk/imx] Error 2
> +make[2]: *** [scripts/Makefile.build:398: drivers/clk] Error 2
> +make[1]: *** [Makefile:1919: drivers] Error 2
> +make: *** [Makefile:177: sub-make] Error 2
> 
> Please fix and resend.

Looks like master changed the function signatures. I'll rebase, test, etc for the next version.

Sincerely
Jonathan Currier

