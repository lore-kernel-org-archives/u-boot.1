Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0159ECF8562
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 444CA84062;
	Thu, 20 Nov 2025 10:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="GTYozxhx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C04B84090; Thu, 20 Nov 2025 10:16:01 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C988C83DBF
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 81E3C10008E; Thu, 20 Nov 2025 10:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763630157;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=7yQTtM2tRfILwfu3yeW6URDZaDMhktNxGhOGkpQdeic=;
 b=GTYozxhx8Mp3fO1Q9EwaFfF/pURhMDVI2tEMge3PiqzWzLwXgDFqphFLPLyqKkuPnd5ZUx
 ngi1LofKKFHRIPL3b/MKUoUDgZho0Jz9x7y2qaKNqV8YDc3TDwIusmYQfAB3SI+v+0Dkdl
 wS1uzFy26TkG5QQsNNwlp1hNoEoWz64qbvowaHfPF/kYJ5IxlJq05uECV+Kk/+JDc4m9sf
 iUGyRd5P7shpZModA+HbeajR8y/La/MVcJyabjM2ZvkucIV5GVkbuAGkDqhocyL6K+C64t
 1lsqLDGg9BeRZMsNXc8KyGvejMRChsSK1bJwY63em6qWjUhy3QWp61yiuVF7AQ==
Message-ID: <2eafbc4e-1072-76f0-535f-9233e5a988ef@nabladev.com>
Date: Thu, 20 Nov 2025 10:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/4] led: remove green and red status LEDs from legacy LED
 API
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "Freihofer, Adrian" <adrian.freihofer@siemens.com>
References: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Quentin,

I added Adrian to cc, as I do not have access to a hardware...

On 19.11.25 18:01, Quentin Schulz wrote:
> Only the Siemens corvus board seems to be using these two status LEDs
> from the legacy LED API.
> 
> Since we're trying to get rid of the last users of the legacy LED API,
> let's migrate Corvus to the modern LED API instead, which uses DM. For
> Corvus's case, it also uses DM_GPIO (already enabled in defconfig).
> 
> Since there was no use for the green status_led (not compiled in), it
> simply is removed without migrating it to the modern API. If need be, we
> can always add a new gpio-led in the FDT.
> 
> Note that I do not own a Siemens Corvus board so it's a bit of a shot in
> the dark whether it'll work on the first try, only build tested.
> 
> The red LED should be on whenever reaching U-Boot proper CLI, if not we
> have an issue.
> 
> The LED should be controllable with the led command from U-Boot proper
> CLI.
> 
> This is a follow-up to:
> - https://lore.kernel.org/u-boot/20251112-led-old-dt-v1-0-2892d49517db@cherry.de/
> - https://lore.kernel.org/u-boot/20251114162417.4054006-1-patrice.chotard@foss.st.com/
> - https://lore.kernel.org/u-boot/20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de/
> 
> to continue the effort of getting rid of the legacy LED API. This series
> depends on the series listed above.
> 
> Multiple other smaller series are coming. I split the whole thing into
> different chunks as separate series:
>   - "easy" migrations (this series)
>   - "shot in the dark" migration of Socfpga Softing Vining board
>   - removal of LED support for a board with no easy migration path
>   - make Sunxi community bear the cost of maintaining the last part of the
>     legacy API by making it Sunxi-specific,
>   - migrate Olinuxino to new API (which requires net/bootp.c to use the
>     new API at the same time) + remove everything related to legacy LED
>     API,
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (4):
>        corvus: remove green led support
>        led: remove support for green status led in legacy API
>        corvus: migrate red LED to the modern API
>        led: remove support for red LED in legacy API

Thanks for this cleanup!

bye,
Heiko
> 
>   arch/arm/dts/at91sam9g45-corvus.dts | 11 +++++++++++
>   arch/arm/lib/crt0.S                 |  3 ---
>   board/siemens/corvus/board.c        | 22 ----------------------
>   cmd/legacy_led.c                    | 12 ------------
>   common/board_f.c                    | 16 ----------------
>   configs/corvus_defconfig            |  2 ++
>   doc/api/led.rst                     | 19 -------------------
>   drivers/led/Kconfig                 | 28 ----------------------------
>   drivers/misc/gpio_led.c             | 30 ------------------------------
>   include/status_led.h                | 16 ----------------
>   10 files changed, 13 insertions(+), 146 deletions(-)
> ---
> base-commit: c2b25f8f66a31e3fe435c93c4339f95ab4c24b9b
> change-id: 20251119-corvus-led-red-green-a15fe26f39bb
> prerequisite-change-id: 20251112-led-old-dt-dc24605ddc88:v1
> prerequisite-patch-id: e06b5d332948608f593edc40330a7a7abe80076c
> prerequisite-patch-id: 903cc5aabeec81459e5f9ed4e303e9cc7ef56459
> prerequisite-patch-id: b1be6517f7300b65087c91a85478077bb01e90c3
> prerequisite-patch-id: bbcdd7a84ba84f5d68d5e12318531f3f2f8c04b5
> prerequisite-patch-id: 7e2738d9c029f8fcbd894e960fec146a677ed988
> prerequisite-patch-id: d906328e945f5afaae2ef61040913ecfd428dc27
> prerequisite-patch-id: 6b535c241c640032380078696b49915db58036a2
> prerequisite-patch-id: dc105b3550fc6cba4a208dd1e7d98f0e22106d65
> prerequisite-patch-id: a7051c86a817569b412d46eb4af4b22c93cd0e06
> prerequisite-patch-id: 8f0c16b6fb70bf526c239324fd5742f0ee92d20b
> prerequisite-patch-id: d84c4ff840c5d4fdffa8be69eb5ef74cd582861c
> prerequisite-message-id: <20251114162417.4054006-1-patrice.chotard@foss.st.com>
> prerequisite-patch-id: 4ba6c3692d92c5d1e7f0fff8020dc917229c10a3
> prerequisite-patch-id: 85ddefe74b3c49d40facb737c5a6bc5ace49387d
> prerequisite-patch-id: e29be2cc5ae57a81d6e9060b68d7678bd15ea3ca
> prerequisite-patch-id: 674cc3bb2f266874a1f39b7ccd86266fc3085e05
> prerequisite-patch-id: d7d3138636356a4e598ce63f9644481872c5da71
> prerequisite-patch-id: 45d6c3582f5716d86e2efb81b606d09974c57dd3
> prerequisite-patch-id: b17c48a1a8ab6aada27c767d15a191d36606609b
> prerequisite-patch-id: 19496299d7c21a1a709c499c06990878d268573b
> prerequisite-patch-id: 3d4e605b49cee688c1c98840268da8690bd6c5a9
> prerequisite-patch-id: bbf09a918a20ca40cb0ad1694e79e1cd0864309a
> prerequisite-patch-id: 3dbebc3c6a91bd766f95392625d8fed140d8bfdb
> prerequisite-patch-id: 7f0d951def11fe1f97224662644a1663c834638a
> prerequisite-patch-id: 55df05baa63656dbc074855ea2f391de14d6530c
> prerequisite-patch-id: 24e03e393be8f5737f0e8f444d3340826552e810
> prerequisite-patch-id: ca97c22ea834c0afb5586e721aff7cb39efd539d
> prerequisite-patch-id: 8e8a80297e82e0a72a8d3dac9134cb5c62e58b7a
> prerequisite-patch-id: b92d833519a5a605c2129ea08a4dc32cbdbab36f
> prerequisite-patch-id: c141f398e49903567732b6cab730de1112f61207
> prerequisite-patch-id: 6900302b3d1364dc1e5a82643ef0f0cd20f4006e
> prerequisite-patch-id: 3600c976c13534519ca5d0891a9c4f665dd761ed
> prerequisite-patch-id: 0b158776d189ce8bf47644b490aa9feaf1229e53
> prerequisite-patch-id: aa471cc044809dab0ca6068615cfeba8f3bce121
> prerequisite-patch-id: 4f7546b5da396a4913f3c97b0288c3a57c2d8043
> prerequisite-change-id: 20251119-legacy-led-unused-code-d635c95cfae0:v1
> prerequisite-patch-id: 4ba6c3692d92c5d1e7f0fff8020dc917229c10a3
> prerequisite-patch-id: 85ddefe74b3c49d40facb737c5a6bc5ace49387d
> prerequisite-patch-id: e29be2cc5ae57a81d6e9060b68d7678bd15ea3ca
> prerequisite-patch-id: 674cc3bb2f266874a1f39b7ccd86266fc3085e05
> prerequisite-patch-id: d7d3138636356a4e598ce63f9644481872c5da71
> prerequisite-patch-id: 45d6c3582f5716d86e2efb81b606d09974c57dd3
> prerequisite-patch-id: b17c48a1a8ab6aada27c767d15a191d36606609b
> prerequisite-patch-id: 19496299d7c21a1a709c499c06990878d268573b
> prerequisite-patch-id: 3d4e605b49cee688c1c98840268da8690bd6c5a9
> prerequisite-patch-id: bbf09a918a20ca40cb0ad1694e79e1cd0864309a
> prerequisite-patch-id: 3dbebc3c6a91bd766f95392625d8fed140d8bfdb
> prerequisite-patch-id: 7f0d951def11fe1f97224662644a1663c834638a
> prerequisite-patch-id: 55df05baa63656dbc074855ea2f391de14d6530c
> prerequisite-patch-id: 24e03e393be8f5737f0e8f444d3340826552e810
> prerequisite-patch-id: ca97c22ea834c0afb5586e721aff7cb39efd539d
> prerequisite-patch-id: 8e8a80297e82e0a72a8d3dac9134cb5c62e58b7a
> prerequisite-patch-id: 3a1b906e26d94930b7634ae0ca35c5043b37f617
> prerequisite-patch-id: c141f398e49903567732b6cab730de1112f61207
> prerequisite-patch-id: 6900302b3d1364dc1e5a82643ef0f0cd20f4006e
> prerequisite-patch-id: a0b2962b16facff0acc9b63ab9884400c1df8fd3
> prerequisite-patch-id: 0b158776d189ce8bf47644b490aa9feaf1229e53
> prerequisite-patch-id: 2793fca5e19cd95cb92e477b2fe1e0179ce0e9e4
> prerequisite-patch-id: 4f7546b5da396a4913f3c97b0288c3a57c2d8043
> prerequisite-patch-id: e06b5d332948608f593edc40330a7a7abe80076c
> prerequisite-patch-id: 903cc5aabeec81459e5f9ed4e303e9cc7ef56459
> prerequisite-patch-id: b1be6517f7300b65087c91a85478077bb01e90c3
> prerequisite-patch-id: bbcdd7a84ba84f5d68d5e12318531f3f2f8c04b5
> prerequisite-patch-id: 7e2738d9c029f8fcbd894e960fec146a677ed988
> prerequisite-patch-id: d906328e945f5afaae2ef61040913ecfd428dc27
> prerequisite-patch-id: 6b535c241c640032380078696b49915db58036a2
> prerequisite-patch-id: dc105b3550fc6cba4a208dd1e7d98f0e22106d65
> prerequisite-patch-id: a7051c86a817569b412d46eb4af4b22c93cd0e06
> prerequisite-patch-id: 8f0c16b6fb70bf526c239324fd5742f0ee92d20b
> prerequisite-patch-id: d84c4ff840c5d4fdffa8be69eb5ef74cd582861c
> prerequisite-patch-id: bc18b41151c9198e1dcaedf483b5d31aae40f0ca
> prerequisite-patch-id: 18f4952525fe4c8c3ab1ae1685e84b65d71c8634
> prerequisite-patch-id: 1d432ed6b7fb6482f98a336cdebae29cec8e7a30
> prerequisite-patch-id: a096ab165f9fcce2e5806012d385f6fd6cf0f6b5
> prerequisite-patch-id: 9677d1503c67524e554b4f7fd8ab5f0cc940e715
> 
> Best regards,
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
