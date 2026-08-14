Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08065C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 21:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C47F46067F;
	Fri, 14 Aug 2026 21:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f-kw4sV6QawU; Fri, 14 Aug 2026 21:24:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D85296069A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786742653;
	bh=5W8HkHI42U2FiYMIQa2rIyv9b4T3BZxhZ1J8JoIJnZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IQ/tnfdJhcnQ/zqEAmJS9gTyVOiFvrwzWWcdt/j27BpXkS9gMKthZhjLMqz9LMaru
	 pEMFGkduO8bg6XKf0J37IfDk6rVlWy+QIJ3qXp8tzU+aXucmO9GE25+tOb8iKGij3o
	 hceEmxyHkxmXhTqW5B+pH42Z8BiPV/RB6CGGRb0KjeKvWmNF4p53ynuhy94y06SCCi
	 Q9N6o2AcKXqqI1A5YH0N34vPhjh7Kbr8FiFOvtQyfD0MNNPiKfxhH21/UI5PJHBfkA
	 4m+mhomnUFpQW8eQBFnMxEQ86As63BMqPQwnIV5U32OZwrAyHthQFC11ao7qh0GuLs
	 vdo6EmJJQisoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D85296069A;
	Fri, 14 Aug 2026 21:24:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CB41194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E63880C45
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:24:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KfuLexOnoU_T for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 21:24:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E7EEF80C35
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7EEF80C35
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=X0CTweHm
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7EEF80C35
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:24:10 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso14963755ad.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786742650; cv=none;
 d=google.com; s=arc-20260327;
 b=KB7CpWXZK5k5aou8qmM3j6V9oe/tr1TY+ioXQes+fHnTtfpiqBRxw2gWas58m2dOdL
 QU7UCN/ZQe4dAwFRFkLYWvj6aRrDvMRykUv4l9d1XpRuYzQrK57/s+9h4DRNoPbDMH4F
 v9oYJeaZo0WZa0OJ/KKMcEunSlZMGxi18Ibq4aN1AXgBSRWBLmMzvUXo3udjXLTxFTVz
 pkUA8tPnjL+hs2wkwRUFkx3Z967QCAK2hoVGzmNWLng8Iyb+7xwKWBTFMVSBiW3ibauB
 UvzyMpqFEiHewvFFtltVh6n81AoHI/74y9S5rr9mzubsyint57Mwysjun7ibn2hecl2p
 M6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5W8HkHI42U2FiYMIQa2rIyv9b4T3BZxhZ1J8JoIJnZM=;
 fh=LpbDjGizNdTi3am7V54pRbGnMopdQTA1xxuRt61RYzE=;
 b=JzZylzaOnhkg+8BdHmjCjDU/1vUjuXlzIulTR7vxKbxPG62VbL6TedG572cQuH+U0M
 e+PW6u1lMzYGa3IztqScLuqiYc73pchmryveEK+LYZTRKxMPSkNBF9O42hHDSUliXG0e
 Xr5ITJ/uFNrRUiZJ5Sa1HXYTm+CVEzP3urkupcG7Oo/vlm4f1grFTgZcAMk1oLnwKS66
 5JhkMK6KigIGOu6zA9OB6gNIvS+1MqAAzFdEUY7FFxkkvb0Zqq973oZMvcuXsyrFF/Lv
 tKfHMUlBIwekts2sEK8B8J3gNXr+EwZwFXzsyzdQv5a6wGmC1LlAJsVuT5zB6dLEJ+l5
 HYfw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786742650; x=1787347450;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5W8HkHI42U2FiYMIQa2rIyv9b4T3BZxhZ1J8JoIJnZM=;
 b=X0CTweHm+1hHYvQWZHYRAAbimaDzTA4tv6XCDt3hUuemf1s68AT27V564vqrTKVffs
 oJuW4PQCpZZJ2OAgp/wtAncY4PNvt9xgEI1Zedrcf8pxKdJeo0k1OU0CqWSxnCQ7YqsN
 PaJ5OIfH3dl0nVGgMLtgd8jdASOGOUfb7EW1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786742650; x=1787347450;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5W8HkHI42U2FiYMIQa2rIyv9b4T3BZxhZ1J8JoIJnZM=;
 b=JV8MqvFZKLbevwTEbNlx3ohUpvZbBBBTKeMz9WKFBBr77//oYBNpC6UL4uQdQFPdVb
 Ctkk028J0Mzdmm33cYeKCi6Qs842MXJCjJwPtV1lOmZ0GmtXCfsRbkWpYlXgI9CrdO9k
 bn0h0c8p+xyyymo+xckpcpDxEycrFsdxUwqQN7ZeVLhgwxeR4tym2ePe2FmB46y4bTnn
 nxI1bKGXvWzee5FOfE6NNiu6U3TY078cn3MnKGtQqP53cFh4irh2q0K3uwOM6e6aISNA
 D9dYF1paue46wSiyFTl6apDp2Uvoc+eb7fTYe9gnKwGkQ+BnwYKcmdSiFU921XxtrnTk
 3HmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqp9o86JZn53xnp6s5MJc/kTQKOY+bUEn4nZLXTgi9to1gpVHK/zKETwTx7G3ZV/IW4vVbEndg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx1yp3PZZkMS7d+psAchPphi4MGJQlLnrE0/WfjyRnLAj4SpXuf
 Pqgc7lr24CTIj66zhUNjC/MZcZttgssylINsR5y5XopEVHhKTn/uvoHg77TxErVhE8Iv31+rPCK
 ZSAHhM5pU721udv/QfMb8+oSfnlt+C7cU8jXRjGro
X-Gm-Gg: AR+sD12CvShE3ZajeA0EagWl2cRRCgQo8p7zkhqP5EkPUdnkkuUPOIjpfX8tmMEOGrq
 xVCZ3IbIRPF2jLhrmx5JpS4ldgDw/uN+Yhb2aC6Ii7O3QfIjssy0PWzQZ4yeAOJvlmHtb5kCTi1
 blWLGdXrGqMhSnBdwQ269+fcnTvAzK8ZLiCHvuzKhMfRhYhRhCofX9onBgbEfRqrof+aQDakHN/
 UN4+mTBD8Y+KCOz7+VYvOax6BQ7YGEyKts8e2bTgTdhYNAbZIhBbVF9TvpMDprXNo0CwzyV6RLE
 KZTdwJ/qdIHe0nKsCrlCSvY4GyuvpZR1C8mzNzXXYiI=
X-Received: by 2002:a17:903:1b66:b0:2cf:b68a:340 with SMTP id
 d9443c01a7336-2d3b0c43462mr105270565ad.10.1786742650113; Fri, 14 Aug 2026
 14:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
 <20260814-imx93-secureboot-v1-5-0c3c78020d03@bootlin.com>
In-Reply-To: <20260814-imx93-secureboot-v1-5-0c3c78020d03@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 15:23:46 -0600
X-Gm-Features: AUfX_mx936Yul3hXpFWI6DSJqMqCzDcVAsFvCABw_YU6ea3qa41inDw-SZLAw-I
Message-ID: <CAFLszTh6MDfPM75QgLBvwu34cpJ7aeBJZxHXN0uexUFyoDLphA@mail.gmail.com>
Subject: Re: [PATCH 5/5] binman: test: add code coverage for nxp_imx93cst etype
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Denis Mukhin <dmukhin@ford.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Alice Guo <alice.guo@nxp.com>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex.vasut@mailbox.org>, 
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi J=C3=A9r=C3=A9mie,

On 2026-08-14T17:07:09, J=C3=A9r=C3=A9mie Dautheribes
<jeremie.dautheribes@bootlin.com> wrote:
> binman: test: add code coverage for nxp_imx93cst etype
>
> Add test methods to cover all code paths of the nxp_imx93cst etype,
> reusing the pattern of the nxp_imx8mcst as done in commit 0cab35362d77
> ("binman: test: Fix code coverage for iMX8 and cst bintool") by Simon
> Glass.
>
> This brings nxp_imx93cst to 100% coverage.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> tools/binman/ftest.py                              | 78 +++++++++++++++++=
+++++
>  tools/binman/test/vendor/nxp_imx93_csf.dts         | 18 +++++
>  .../binman/test/vendor/nxp_imx93_csf_imagename.dts | 24 +++++++
>  3 files changed, 120 insertions(+)

> +    def testNxpImx93cstELE(self):
> +        """Test CST signing with an i.MX93 SPL container including the E=
LE
> +        FW"""

Please keep the docstring on a single line to match the imx8 tests
just above. It fits within 80 columns as e.g. "Test CST signing where
the SPL container starts with the ELE FW".

> +    def testNxpImx93cstSigned(self):
> +        """Test CST-signing-success path with mocked cst invocation"""
> +        spl_data =3D bytearray(64)
> +        spl_data[3] =3D nxp_imx93cst.CONTAINER_HDR_TAG
> +        spl_data[12:14] =3D struct.pack('<H', 0x90)
> +        spl_data[40:44] =3D struct.pack('<I', 0x123)
> +        self._MakeInputFile('imx93-container.bin', bytes(spl_data))
> +
> +        # Mock run_cmd() so that when cst is invoked, it creates a fake
> +        # output blob and returns success, thus covering the signing pat=
h
> +        original =3D bintool.Bintool.run_cmd
> +
> +        def fake_cst_run_cmd(self_tool, *args, binary=3DFalse):
> +            if self_tool.name =3D=3D 'cst':
> +                arg_list =3D list(args)
> +                if '-o' in arg_list:
> +                    idx =3D arg_list.index('-o')
> +                    tools.write_file(arg_list[idx + 1], b'\x00' * 32)
> +                return 'fake cst output'
> +            return original(self_tool, *args, binary=3Dbinary)
> +
> +        with unittest.mock.patch.object(bintool.Bintool, 'run_cmd',
> +                                        new=3Dfake_cst_run_cmd):
> +            data =3D self._DoReadFile('vendor/nxp_imx93_csf.dts')

data is never used - drop the assignment (as testNxpImx8mCSTSigned
does), or add an assertion on the returned bytes so the signing path
is actually validated rather than only executed. A quick assertEqual
on the length (spl_data plus fake 32-byte blob) would give real
coverage rather than only line coverage.

> +    def testNxpImx93cstUnknownTag(self):
> +        """Test CST with unknown input tag passes data through"""
> +        # Trigger the pass-through path using an input without the AHAB
> +        # container tag
> +        data =3D b'\x00' * 64
> +        self._MakeInputFile('imx93-container.bin', data)
> +        self._DoTestFile('vendor/nxp_imx93_csf.dts',
> +                         force_missing_bintools=3D'cst')

Since the pass-through branch returns early before cst is invoked,
please assert the produced image equals the 64 zero bytes - that way
the test actually proves the pass-through behaviour rather than only
that no exception is raised.

Regards,
Simon
