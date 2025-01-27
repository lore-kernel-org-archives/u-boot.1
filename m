Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE03C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 23:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0ED681727;
	Tue, 28 Jan 2025 00:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="Wj9mro22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBED98186D; Tue, 28 Jan 2025 00:02:56 +0100 (CET)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23134812BB
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1738018972; x=1738278172;
 bh=r2TtobXdk9rpxlPwfwPzYyNtmhgl4KVhI/njFt/sK9E=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=Wj9mro22q2Yyd/tQUwewQ4Gv8i3CZgkR1oHdxkgmg+bSv0IA09tpEuH41ZrQczBFT
 q6qhwl/1l7jmwuLfcCEzLV141tMeYVw/nOSCc4/an+JCr000/do2zgtTtueNFVrDnn
 DKa2+TkPYkvdJAHqpOk64xxSRG/PDyD16WZMmKpbqKtxyVFUXtsoJyt61yRsWbLOYL
 wT1lvgAA2WtU7SUzBYYi8v4xfmsGPK0AWiuAq8r+sRLJOeyGP/1uydrYisSwEILdUk
 ODVq0e2gkYBemWZKFVLGQ5Lvnsm34r3Cb9+NOzvLpJ3CwTvC3Xh7JZRJm4wenQxuOn
 JqlELSLEQTMVw==
Date: Mon, 27 Jan 2025 23:02:46 +0000
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Subject: [PATCH 0/6] MSM8916: Bring secondary cores online with spin-table
Message-ID: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: eef8c574e904531c1ddbf04c0befc79773d1c1f0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

This patch series depends on the "mach-snapdragon: handle platforms
without PSCI support" patch that was submitted earlier today. That first
patch lays some groundwork to handle detecting when a device is booting
without PSCI and deletes the /psci node in that case.

This series builds on top of that detection by rewriting all CPUs with
enable-method=3D"psci" to "spin-table".

Once this is done, the existing spin-table support in U-Boot handles
further patching the nodes with the appropriate cpu-release-addr and
reserving the memory with the spin-table instructions.

Interestingly, this spin-table code doesn't seem to be in active use
anywhere, and it had bitrotted a little. But after blowing the dust off
it and fixing a couple of missing #includes, it works great.

I extended the spin-table support a little to make it easier for
consumers to plug in a method that is called for each CPU that needs to
be brought online. This saves the qcom board code from needing to hook
into ft_board_setup or something that runs before booting the OS.

Signed-off-by: Sam Day <me@samcday.com>
---
Sam Day (6):
      armv8: spin_table: Fix missing includes
      armv8: spin_table: add hook for booting cores
      mach-snapdragon: qcom SCM call support
      mach-snapdragon: fixup CPUs with PSCI enable-method
      mach-snapdragon: MSM8916 spin-table CPU boot support
      qcom_defconfig: enable spin-table support

 arch/arm/cpu/armv8/spin_table.c        |  10 ++
 arch/arm/include/asm/spin_table.h      |   3 +
 arch/arm/mach-snapdragon/Makefile      |   2 +
 arch/arm/mach-snapdragon/board.c       |  41 ++++++++
 arch/arm/mach-snapdragon/msm8916-smp.c | 135 +++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-scm.c    | 145 +++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-scm.h    | 165 +++++++++++++++++++++++++++++=
++++
 configs/qcom_defconfig                 |   2 +
 8 files changed, 503 insertions(+)
---
base-commit: 2eed5a1ff36217372e19f7513bd07077fc76718a
change-id: 20250127-msm8916-smp-support-5f5e7b49d07e
prerequisite-change-id: 20250127-qcom-handle-absent-psci-6e8e8af7bcd7:v1
prerequisite-patch-id: 6f85e145b7a25346a286396d9edf6106ae131c0b
prerequisite-patch-id: 3b11763ea1d10ae9e23cb5c1b888f02220919284
prerequisite-patch-id: 030300d29b72f14fc528f2ad46c0d9e229934e9e
prerequisite-patch-id: de0427537d887654f8dbf2e97ca6a3bc956512cd
prerequisite-patch-id: 30db99afc91f657e484d4bb5a6613b64fb77649b
prerequisite-patch-id: b1c46de57d0f82756d2bbeee6d13cf31c1f27a0f
prerequisite-patch-id: 2d7d38f6ea846a5f183462d07ff962182e20a87e
prerequisite-patch-id: 76ce7f79c8f4e2a5042dc8804194b0bef2d0a24b
prerequisite-patch-id: 05eac938e6d33019a091ee721eba2d2dc7a03960
prerequisite-patch-id: 243fe8829719909ab6d65b512b0efcff4f4c9438
prerequisite-patch-id: fb7780ba617c036bc3b4e8fbc53541d485ae89d8
prerequisite-patch-id: 16e2a268f01739da59598b5f5b0d86a80c31449f
prerequisite-patch-id: 43e1512fd0768b763cdf2079dce0054a736e97ea
prerequisite-patch-id: 02cffb68f48d9d64c26373d6366c82bfcb86a7a2
prerequisite-patch-id: 19f382ead12fd5f583ad8b82fe618e6dd2c59615
prerequisite-patch-id: 764cc2a29ae7486610b6279cd71bedfb267f18bd
prerequisite-patch-id: e22fa6b807a5df8e0257636a3edf8de92d4b3a36
prerequisite-patch-id: 159efbb7a5bd037b11eb20993716bdc7e641c89f
prerequisite-patch-id: 0c4373ed5bda9e74a488796de8ce2e0c59c62c46
prerequisite-patch-id: fb2e81bbe11eed5d7af8ac4b1c2a29e2bdb6b237
prerequisite-patch-id: b105b1ec3f2ab8d9ad212eacf3a4736417950930
prerequisite-patch-id: 302c34fd65875a4a750a5a36b933e43639859487
prerequisite-patch-id: b1b62ac7e28eb0cc8a66d529911d6294b40cc5cd
prerequisite-patch-id: 43de5453463d592c16d5669345528ded4e897605
prerequisite-patch-id: 861de3de3e008cfffcbcbfdd25c5bf1cdd9925ea
prerequisite-patch-id: c91bbc83ea9d167f2451c7e9a13692c4cc92d1cb
prerequisite-patch-id: cf9a09214da66d4bb1175b40a4e49c98212aaae3
prerequisite-patch-id: 671819fe6f2c93b420fec5ee283149d8e51a4f1c
prerequisite-patch-id: 02a9a32547b5e850d27ada3bed7e88b4c970d342
prerequisite-patch-id: cb7baa3ce35948742a83d9b4acb7449f660818a6
prerequisite-patch-id: 9dd97eb36b380b64b43fb6718075106e1f4186c5
prerequisite-patch-id: c9ef7bfbbcf3a55a821dac749236440ae10fc89c
prerequisite-patch-id: d37f02b2f520d3a84e5b4a515f88d217f78841ee
prerequisite-patch-id: ad99b38cc1326272ec03e7cdced069e76b850d59
prerequisite-patch-id: b7467e24f0a21c08a52008374e18d3af996e0668
prerequisite-patch-id: a7d97af191a6adfb55af0fd89bdb97c378f86f65
prerequisite-patch-id: 87de3dd294acc2a220d97142bd615bdcd01fb00b
prerequisite-patch-id: 5f2a37841670e9b941dce8f8b28c3e7e6c6048f6
prerequisite-patch-id: 5a77c17b8b78e760cd9bd4982d564fdb60ba667e
prerequisite-patch-id: afa8a5a8572452ff8ac2f0dac1fc132fc5423150
prerequisite-patch-id: d68ce45f8993ba7c6967c28c25abdbc0f78a2cb3
prerequisite-patch-id: 218f70c55c7ca23f1de87e5370655137e796c725
prerequisite-patch-id: 2f5b57d1cf40ef18ed9f942bee4dd35ad60f5c43
prerequisite-patch-id: 2e2278e28f7795aa48916be2e4865cc915d602fd
prerequisite-patch-id: e86660dfec6465dc87f3deaeddc1bb814c7dd801
prerequisite-patch-id: a5136d73559a8eaee5ce7e460842ba02d8c7f7c7
prerequisite-patch-id: fae5d78eb2da7d044ee6408d03a887d537dedaae
prerequisite-patch-id: 27dfcabf70c4b88395eabf07a60b286d4d1856d2
prerequisite-patch-id: 5414352fb0926632f6b9c4904f0240c2976ea38f
prerequisite-patch-id: 3036949e76a7d5467b4c0842f852b84a1a48ae84
prerequisite-patch-id: 76cc9440f2cbd13090eebeb4c25c20dbb990049c
prerequisite-patch-id: 7549f8d500cf0ce56b49c78fc3412353cd080ac4
prerequisite-patch-id: 19e7341bcdce3e1f39acf2125b44ea011f3352e1
prerequisite-patch-id: 2830a95408413ac5d4b8869e58006b2529fb1af7
prerequisite-patch-id: 097945624a0249b81bc3e7f747d7c54b1552f121
prerequisite-patch-id: 12e71f9202bdab483de4fb275710fcd738b89e99
prerequisite-patch-id: 6ae4a39f434fd00c4ba139ff1d91d0c9275cb208
prerequisite-patch-id: a0c8c2f64bb5951eb1794a6cf685d9898baa56ca
prerequisite-patch-id: b5143f5cfec77eb66f2f3c65a2614d715255c1a7
prerequisite-patch-id: 7042961e52dc6a3691064c8f0cdeea611ad2d5ec
prerequisite-patch-id: 36f5fed167531209347d743c8289150508684979
prerequisite-patch-id: 3ddd71ec0fa373ce98a05a7a5cbdc84399a66efc
prerequisite-patch-id: 7fdce16aa47fe89f7c1afae677042edf2735385a
prerequisite-patch-id: b841df88415770b8e7771104233179b35773e473
prerequisite-patch-id: 60085daf50c7c2b629f522069a51c480b3218f05
prerequisite-patch-id: 873eed9fa8f975be3cf37fac3ed662250ce11771
prerequisite-patch-id: a5ac5acc7b7c182fe008d856cc9bbaa2c5e9633a
prerequisite-patch-id: 3939201e8927f038d843dcc9e0dd67781d73ce53
prerequisite-patch-id: cf6b26bdc312e808b1ef702e323cb7ab0f82b6a2
prerequisite-patch-id: 2dc7feea1ab83bab9852bc95a6c9a7d6a7006aac
prerequisite-patch-id: 5ec17e2221f23dc8f10803404256db6b2ea86f17
prerequisite-patch-id: 0f8b032d456dda766799580f1185a124bafe3ee3
prerequisite-patch-id: b168c68d649ac27e2416a3bf1ae7b9b6a90822b8
prerequisite-patch-id: 69a892386b52cb7aa0839472ee96f5c0f9ac5ef3
prerequisite-patch-id: 7c0fd076b848535a0f0d5abb6fcbbc836f71b4e4
prerequisite-patch-id: 0800bc8110bdb23f177cdc8e6d80dcdb2f3b3059
prerequisite-patch-id: 22c12428b5345883a30f2e0dfbea78defb2cc5e2
prerequisite-patch-id: 889de73156ee67862e5a9eb00cb43934d1848afb
prerequisite-patch-id: 122e9b8f48e2f67e10ec4345b4aaf5feba81b40a
prerequisite-patch-id: ec144dd1adc629a0d8d7bc4ee0b520344faf0322
prerequisite-patch-id: a7c6c37875075e7d31a9eec9e50fb0cf960ccfa6
prerequisite-patch-id: a1f683dae05a61bdf15df04454960af2481b9ff0
prerequisite-patch-id: f031c546205485ab0dbde83e962f7a2341c62645
prerequisite-patch-id: 05c5e3f7c07d0c3072c59cd0cb1262e5f480a589
prerequisite-patch-id: f54e3917db830329ef185dd89c27085cbefb1881
prerequisite-patch-id: dfe80f29b2ef88d5cbe668949a74459ef53c660d
prerequisite-patch-id: 2d85a2c47df09ba5831265c2119bf045d6bdeacd
prerequisite-patch-id: 1439383a5a62edd6186af4705a5b4f59d27f4c40
prerequisite-patch-id: 11defde4d0eb072a2c2bcf022af0598edd597051
prerequisite-patch-id: 92b8c0b688026554b3633440f61572fd451c617e
prerequisite-patch-id: 09c8682d1d6cb5ff1af975308ca039f25fe4c59a
prerequisite-patch-id: e7c5c0b05eb4a395c93908dab766b3840dc3b302
prerequisite-patch-id: fa4c72a2c5d13579a831a41e9235e245b78a7dbc
prerequisite-patch-id: a4ad3b9360284a935f1dd98a3bd01a765c8aa5bc
prerequisite-patch-id: 32e46850ee3f2ae42aa806bc236ec4474c35dca0
prerequisite-patch-id: b0ba05b2600ec4767e8deb88fb39c261ea317a6d
prerequisite-patch-id: a6841b49255ec70ffeff8470ffe3a0dbf65ee7b8
prerequisite-patch-id: ec523fb216a7dffabeb1b0966603c01bcd30c425
prerequisite-patch-id: 29559b5916dd715a8daec623c4a52a2896c4f853
prerequisite-patch-id: 935e2b0efe1f56f9c02d61a44ebd169b8aa01757
prerequisite-patch-id: 207cdd32d4721253767e87bad783e6cfd7894885
prerequisite-patch-id: d4fede4e48324bcbad94166381520e86de8c6b58
prerequisite-patch-id: 37e1e35c443f31444a815e7fa09ab9193b58ff33
prerequisite-patch-id: 89cfa619d48fc54564390069b445617e9cd3f272
prerequisite-patch-id: a4934111361709dec17274b4a9840b388e40927a
prerequisite-patch-id: 84f11a9b07d4f28ecef51a8e689840c6650c29fb
prerequisite-patch-id: 62f7cfc8675a161612ab84e6884baa0289140037
prerequisite-patch-id: fb6f1d0041b49bcf1a568af97be5221fba0bee68
prerequisite-patch-id: 4542cc51d6726e7993581124a2691821eaef06c7
prerequisite-patch-id: f801ea78e28a1d6a2f8a25c3376de7517b3a4f2c
prerequisite-patch-id: 1e50e99eef583a5ea2e03a66363045b57146305f
prerequisite-patch-id: 333e1147f78607d03964774cf2ccf7c16eea5e4a
prerequisite-patch-id: 501c4d1e9f26129440505bcd08f62eee38605c31
prerequisite-patch-id: e58d99831b9ff24ebfa92ec5cab91eefa3bde05f
prerequisite-patch-id: c29d323121307cf9e14bfae5b72aff0b281adb42
prerequisite-patch-id: 78c5227d2d0aebd3039d084bbeb517330c3f258e
prerequisite-patch-id: eb502f8a13b74b8689304ab1e8993bb79ff4518b
prerequisite-patch-id: c91159b4e90be4afa72dcda32efdf42dd8ca3888
prerequisite-patch-id: 0f125a3f46e7bb243cb78e9be0d74f318858a3ab
prerequisite-patch-id: e3a1f152d9bb9c949a32ae1ec233c63bd7ad24bd
prerequisite-patch-id: d6f656b49d9c1e0ed666732305db8d4e6ae9c9c9
prerequisite-patch-id: c41aff811e5487ecb069cacea0e85a358333dc37
prerequisite-patch-id: ff87d23252f02cd6a9abd43e71740968057f263a
prerequisite-patch-id: fcab7e05ba0af8c43fce5149e952c69833c7c3b4
prerequisite-patch-id: b044600fd11584b74923079843b1456b480d5fa5
prerequisite-patch-id: bb963c51f31c76af938f8561c8779ed0f8511b7f
prerequisite-patch-id: a9a675e9db9d2a0ec36a6ade80855636878b7d21
prerequisite-patch-id: 37caa389ca0cee716ab9408370bf9dbcac6a9d09
prerequisite-patch-id: ecc7ad1d94f8290f27c7749d27d1bebf5d11bf19
prerequisite-patch-id: 0966beb3fd1f486a79c791fc0a58c090533e789a
prerequisite-patch-id: 2695a9bbf667850304a9c87c33d96db47f15504c
prerequisite-patch-id: 1056292d88bb2ba81223a3315e52204078aa34f8
prerequisite-patch-id: 8c8bea9e74f88cd68e7096479f03353b0a77d35e
prerequisite-patch-id: 3fb86a0aa7f1431e5480101cf992174eb9763c5c
prerequisite-patch-id: 4229a08c9b3e78251f0fd12cca3b33b38f9c53b2
prerequisite-patch-id: 5b023bd57576a846cce1f9091926cf01af1e09e0
prerequisite-patch-id: 760da8469c8db63b0e5173079057ba1c91748688
prerequisite-patch-id: 8bc19d02fe8fd85c2c729de88e12a236549386b0
prerequisite-patch-id: 6c67a9cae4b0a873402355eac2e26943e6ac4ad6
prerequisite-patch-id: cffe93501f50aa986a4d0546614e59ad16b1b6b8
prerequisite-patch-id: cb823554e6cd1c736535944e1c87fb397e31d7e0
prerequisite-patch-id: b6b2b1079cd9864d9d785cbba7656706f2019357
prerequisite-patch-id: aaa2d626cfc8cdb4130a45706fdcb743de34e06f
prerequisite-patch-id: 6511f02f5192e70025a03c323232c1925d5ec9ab
prerequisite-patch-id: 4d49e42ca5ead7cc03372c6d99189d98d4af03ba
prerequisite-patch-id: ee16181118c1b9f04a802ac725da9681fa5473b8
prerequisite-patch-id: 65448b5a93120d2117c1361035afc9bd911d005f
prerequisite-patch-id: a1a62f04d90fb71042e2dabb15d1b37c7e7bbff2

Best regards,
--=20
Sam Day <me@samcday.com>


