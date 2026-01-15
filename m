Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2EAD41143
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 09:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1522280077;
	Thu, 15 Jan 2026 10:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NIk2haMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD7608003E; Thu, 15 Jan 2026 10:09:20 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75CBB82BF2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 10:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CB23B44085;
 Thu, 15 Jan 2026 09:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59917C116D0;
 Thu, 15 Jan 2026 09:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768468155;
 bh=KHn4m9yUfnE698BSt55AIREqY2mfCKUHZKmBXa66boc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=NIk2haMTHSRCWbT196s6hzh9xPFXf9/aIPjWy07SH7L2/64eVe//eyB9LtPS+Vbj+
 25VsJzS/0iNCaSMfiikHhhzntZKZHM5Rvi/yJ5fTxvrgTXqDG9dflyRSmBXtO4Ztsu
 BEFaRiwoNfywh4XZIp13RevMrCCc8dKwwb8ee3MlLHVvjcoFvxAa9tF0a8XchRze7V
 9Nd2fWbUM3QFjryBwaho5QX4y3HGR1TkY1uuzTUUy3T7IIpV5DkkdcluwZSAYarKkX
 uMK5e2dnI693N1p7rFkde5UDSOwgMiyPlDYuuAKYQc/QVZ0mCvdo7XFW1UE/+pgEd6
 loHnUwf1k7IXA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, Guillaume La Roque
 <glaroque@baylibre.com>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Maxime Fournier <mfournier@baylibre.com>, Eddie
 Kovsky <ekovsky@redhat.com>, Casey Connolly <casey.connolly@linaro.org>,
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Jerome Forissier <jerome@forissier.org>
Subject: Re: [PATCH v5 5/5] test: abootimg: Add test for bootconfig handling
In-Reply-To: <20260112-bootconfig-v5-5-79b242159ac7@baylibre.com>
References: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
 <20260112-bootconfig-v5-5-79b242159ac7@baylibre.com>
Date: Thu, 15 Jan 2026 10:09:13 +0100
Message-ID: <878qdzfdja.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Guillaume,

Thank you for the patch.

On Mon, Jan 12, 2026 at 11:55, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:

> Add test to verify that androidboot.* parameters are correctly extracted
> from bootargs and appended to the bootconfig section when using
> 'abootimg get ramdisk' with boot image v4 and vendor_boot image.
>
> The test verifies:
> - androidboot.* parameters are removed from bootargs
> - They are appended to the bootconfig section in the ramdisk
> - Non-androidboot parameters remain in bootargs
> - The bootconfig trailer is properly updated
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>

nitpicks below.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>


> ---
>  test/py/tests/test_android/test_abootimg.py | 91 +++++++++++++++++++++++------
>  1 file changed, 73 insertions(+), 18 deletions(-)
>
> diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
> index daa87643e93..760f8e385ba 100644
> --- a/test/py/tests/test_android/test_abootimg.py
> +++ b/test/py/tests/test_android/test_abootimg.py
> @@ -62,22 +62,24 @@ b7762ffff07d345446c1281805e8a0868d81e117a45e111c0d8dc101b253
>  d4a9820881a70f3873f35352731892f3730b124b32937252a96bb9119ae5
>  463a5546f82c1f05a360148c8251300a462e000085bf67f200200000"""
>  
> -# boot img v4 hex dump
> -boot_img_hex = """1f8b080827b0cd630203626f6f742e696d6700edd8bd0d82601885d1d7c4
> -58d8c808b88195bd098d8d246e40e42b083f1aa0717be99d003d277916b8
> -e5bddc8a7b792d8e8788c896ce9b88d32ebe6c971e7ddd3543cae734cd01
> -c0ffc84c0000b0766d1a87d4e5afeadd3dab7a6f10000000f84163d5d7cd
> -d43a000000000000000060c53e7544995700400000"""
> -
> -# vendor boot image v4 hex dump
> -vboot_img_hex = """1f8b0808baaecd63020376626f6f742e696d6700edd8310b824018c6f1b3
> -222a08f41b3436b4280dcdd19c11d16ee9109d18d59042d047ec8b04cd0d
> -d19d5a4345534bf6ffc173ef29272f38e93b1d0ec67dd79d548462aa1cd2
> -d5d20b0000f8438678f90c18d584b8a4bbb3a557991ecb2a0000f80d6b2f
> -f4179b656be5c532f2fc066f040000000080e23936af2755f62a3d918df1
> -db2a7ab67f9ffdeb7df7cda3465ecb79c4ce7e5c577562bb9364b74449a5
> -1e467e20c53c0a57de763193c1779b3b4fcd9d4ee27c6a0e00000000c0ff
> -309ffea7010000000040f1dc004129855400400000"""
> +# bootable boot image v4 hex dump (with DTBs)
> +boot_img_hex = """1f8b0808e2dd60690203626f6f745f6e65772e696d6700edd8ab0d836018
> +40d14f900a0c8c5036e80a24180c24dde04f4034d04740b13d02d90920e7
> +8c70e5adbbe6d9b74d5544441987c72dfe64010000009cd5342e9f71beff
> +d2367fd3900b0200000017b4a4f7f05a2703000000002e6c0765d9bd6000
> +300000"""
> +
> +# bootable vendor boot image v4 hex dump (with DTBs + bootconfig)
> +vboot_img_hex = """1f8b0808e2dd6069020376656e646f725f626f6f745f6e65772e696d6700
> +eddb316bc24014c0f14b2dd20a425c3b393a48c1d0c1a54be9aca588fbc5
> +0b3434e9c979d04628f811fd22426787d2bbc43a68e9d4a5f1ff83f7de25
> +5c787053f220d3d1fde3dd783c39174ee86255e68e4f0000e00405e2e835
> +e0e142886db9fae8f89c95dbaa7ac5890100f02f1899ab74f1dc9dcb22d3
> +52b538110000000000ea67ddfedcb8f2ee6228aa317ecf859fed7fcffefd
> +fae68747835d6dec42bc0df6d74d1fc5a0bfac6e89331797b9564926663a
> +9f4b9bc659f2b7cda383e6517f19fdd61c0000000080d3111e7c4f030000
> +000080fa912fcae854c55adbeb2769d4ab34c9ad4d16963f010000000000
> +a88d2fb468951800500000"""
>  
>  # Expected response for "abootimg dtb_dump" command
>  dtb_dump_resp="""## DTB area contents (concat format):
> @@ -166,7 +168,6 @@ def abootimgv4_disk_image_vboot(ubman):
>      This is function-scoped because it uses ubman, which is also
>      function-scoped. However, we don't need to actually do any function-scope
>      work, so this simply returns the same object over and over each time."""
> -

Unrelated diff, drop please.

>      global gtdi2
>      if not gtdi2:
>          gtdi2 = AbootimgTestDiskImage(ubman, 'vendor_boot.img', vboot_img_hex)
> @@ -179,7 +180,6 @@ def abootimgv4_disk_image_boot(ubman):
>      This is function-scoped because it uses ubman, which is also
>      function-scoped. However, we don't need to actually do any function-scope
>      work, so this simply returns the same object over and over each time."""
> -

Unrelated diff, drop please.

I can fix up when applying if you agree to that by replying to this email.

>      global gtdi3
>      if not gtdi3:
>          gtdi3 = AbootimgTestDiskImage(ubman, 'bootv4.img', boot_img_hex)
> @@ -282,3 +282,58 @@ def test_abootimgv4(abootimgv4_disk_image_vboot, abootimgv4_disk_image_boot, ubm
>      ubman.run_command('fdt get value v / model')
>      response = ubman.run_command('env print v')
>      assert response == 'v=x2'
> +
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.buildconfigspec('android_boot_image')
> +@pytest.mark.buildconfigspec('cmd_abootimg')
> +@pytest.mark.requiredtool('xxd')
> +@pytest.mark.requiredtool('gunzip')
> +def test_abootimg_bootconfig(abootimgv4_disk_image_vboot,
> +                              abootimgv4_disk_image_boot,
