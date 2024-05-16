Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24ADC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 15:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27774881C3;
	Thu, 16 May 2024 17:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="MlaCYnbn";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGLfg411";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC7B8826E; Thu, 16 May 2024 17:07:13 +0200 (CEST)
Received: from wfout3-smtp.messagingengine.com
 (wfout3-smtp.messagingengine.com [64.147.123.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F099E8800B
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 17:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id 794411C0010E;
 Thu, 16 May 2024 11:07:08 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 16 May 2024 11:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715872028;
 x=1715958428; bh=tdFAaPehCgXxITt6hFDcgJGVN2a/8XUwti0wu+g2Ins=; b=
 MlaCYnbnv9XWqgS9heT8BczW+YpXGfG91fYDM/9DFrFsAjpYjpSgVpUKF5D3vkjo
 w5vUdWzhZcjiSuH0rehgT26FHcRpAC+6ApHMgEaQzOjC4xEPxTBpBu06h850tELc
 TeNyWZp8Mu0amPNy3lG+FJHPZjcOZyAPtiv+RFMctuSEZMRa5Gmd12c6d3Cdrsyr
 wbbfPT/s7qdamBLjWEZmDqwZFukrjYqSWJxE55vCjhrtNzc5e/zDDCXR59qpzxTc
 19begE4aDoVMdLzTsNML1rNMC5KNYwDi2L8SN+qhhx/N+/i5fbn0MuYeIpXcbxkT
 6tMG72Z7jdXVLdU+wYVMZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715872028; x=
 1715958428; bh=tdFAaPehCgXxITt6hFDcgJGVN2a/8XUwti0wu+g2Ins=; b=G
 GLfg411a719uX3U29VtUVC1L54KBTxm6/pe40puImcLIRRc1b/e3XSk6vPFZAkbm
 k1qxpOUwooimtQGYemqity2GnsqtbROvE9EkXAoSbHgKYCBtnYWWaiUUcJHSGP3B
 wT6pzA2HIPDO/epU4WEP6dqaxPgthFfIk/VPozFSzpZ2TBWLBppHxEzsKY8ydHps
 0pZ++NFzMQc7JRQ/Or89fThTTD2pf6bSOdCHAcxLmZYy5CDDNOIi2N7IBFGnNDgD
 nwbPd8JLZENPlMcNE0kTyZsmNaISJ5O/RyrdO7T8C8tckPrxFDFUp6OFm38Avb7o
 ipBKKNxFBTTzzSjy6ky8Q==
X-ME-Sender: <xms:GyFGZoeZXpltL_qjPqJRd8De5fwfcTnKCDJa_Qo8V5G1pAWIFyuy7w>
 <xme:GyFGZqPEoC3bHaZybyZaXmL_sZXAWvYKwUIIix4qdR1GcQBBVg7_78HtflSyYkoLK
 1hxWHmdf8rF7RnBrjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgkedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:GyFGZpiDwnUCW_y04wmg1aBkXsfPiC4lRtZiA3UqUzQmjxg4q2h3qQ>
 <xmx:GyFGZt8DEEsJDtr4PU6FXmPBzCnbd0zbY2_mJlxatOP1FXYhcP8rxA>
 <xmx:GyFGZkvEI4k06ZSDYpkmntJF8W5rI6Sf_f4zQ2j-Ta3X4eAwALEQLQ>
 <xmx:GyFGZkGSoAYDWLhwA4v-Z_r_bfSMtEMsE91Fuxg7e2_YTrJ8XugDeA>
 <xmx:HCFGZmLaOa2IO3hB22wQDOgvyVduXQEZ9p-U7-gII5AGsdkkq6Rur9vO>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D7ED136A0074; Thu, 16 May 2024 11:07:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <1559cb32-ea27-4baa-a615-2f7cabda5529@app.fastmail.com>
In-Reply-To: <b6ba47d2-be93-40e8-a1b7-1bd593a933b7@kwiboo.se>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
 <20240516-boston-v2-9-77938800d1dd@flygoat.com>
 <b6ba47d2-be93-40e8-a1b7-1bd593a933b7@kwiboo.se>
Date: Thu, 16 May 2024 16:06:48 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Jonas Karlman" <jonas@kwiboo.se>
Cc: "Michal Simek" <michal.simek@amd.com>, "Tom Rini" <trini@konsulko.com>,
 "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 "Simon Glass" <sjg@chromium.org>, "Lukasz Majewski" <lukma@denx.de>,
 "Sean Anderson" <seanga2@gmail.com>, "Sumit Garg" <sumit.garg@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 09/12] clk: boston: Allow to get regmap from parent
 device
Content-Type: text/plain;charset=utf-8
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8816=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=883:00=EF=BC=8CJonas Karlman=E5=86=99=E9=81=93=EF=BC=9A
> Hi Jiaxun,
>
> On 2024-05-16 13:40, Jiaxun Yang wrote:
>> In upstream devicetree, clk_boston is a child of syscon node
>> and there is no "regmap" property for clk_boston node.
>>=20
>> Try to check parent device first to look for syscon.
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> v2: Move syscon_get_regmap to probe
>> ---
>>  drivers/clk/clk_boston.c | 37 +++++++++++++++++++++++++------------
>>  1 file changed, 25 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/drivers/clk/clk_boston.c b/drivers/clk/clk_boston.c
>> index 030ff7cc58ec..1985bb0ec334 100644
>> --- a/drivers/clk/clk_boston.c
>> +++ b/drivers/clk/clk_boston.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/printk.h>
>> =20
>>  struct clk_boston {
>> +	struct udevice *syscon;
>>  	struct regmap *regmap;
>>  };
>> =20
>> @@ -58,23 +59,33 @@ const struct clk_ops clk_boston_ops =3D {
>>  	.get_rate =3D clk_boston_get_rate,
>>  };
>> =20
>> -static int clk_boston_of_to_plat(struct udevice *dev)
>> +static int clk_boston_probe(struct udevice *dev)
>>  {
>>  	struct clk_boston *state =3D dev_get_plat(dev);
>> -	struct udevice *syscon;
>> -	int err;
>> =20
>> -	err =3D uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
>> -					   "regmap", &syscon);
>> -	if (err) {
>> -		pr_err("unable to find syscon device\n");
>> -		return err;
>> +	state->regmap =3D syscon_get_regmap(state->syscon);
>> +	if (IS_ERR(state->regmap)) {
>> +		pr_err("unable to find regmap\n");
>> +		return PTR_ERR(state->regmap);
>>  	}
>> =20
>> -	state->regmap =3D syscon_get_regmap(syscon);
>> -	if (!state->regmap) {
>> -		pr_err("unable to find regmap\n");
>> -		return -ENODEV;
>> +	return 0;
>> +}
>> +
>> +static int clk_boston_of_to_plat(struct udevice *dev)
>> +{
>> +	struct clk_boston *state =3D dev_get_plat(dev);
>> +	int err;
>> +
>> +	if (dev->parent && device_get_uclass_id(dev->parent) =3D=3D UCLASS_=
SYSCON) {
>> +		state->syscon =3D dev->parent;
>> +	} else {
>> +		err =3D uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
>> +						   "regmap", &state->syscon);
>
> This will trigger a probe of the referenced regmap phandle. To simplify
> and avoid probing devices at of_to_plat() stage, you can probably just
> rename of_to_plat() to probe() and skip of_to_plat() stage completely.

Thanks, will fix in next version.

>
> Regards,
> Jonas

--=20
- Jiaxun
