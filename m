Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA64CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 07:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 331F286DD6;
	Thu, 12 Oct 2023 09:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cuI/1XD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B263086D41; Thu, 12 Oct 2023 09:23:38 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F07A86DFA
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 09:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697095405; x=1697700205; i=xypron.glpk@gmx.de;
 bh=Q5W1WT8nZRBWUaNOl/NzDaYUKP4vO7066P1iCAdgnQI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cuI/1XD3DpoePb6YYmnra3Iv3nQ6cTjXq30e+3pzr+T8/PO6UdsjBkA/Y63BU8n1yamafb1m3mi
 Vwk28RnfsYc8HeAxtwZjV3nz1Lfmhkh/2f/YLb0FO9As6/dAbyGgoE5XpqKM7s0c2L4NH555SkFPv
 NetewDQ2QqPKnGNowIeIR0UhmiEBtHtnpBc631eSzPdnnZb9uB78Y5ul4znsHj96gyloC4VlAuPtu
 /I0ewTHR90K08aiWdNtMSkxI2vo23TKrud7+AIH4wuz8uVhg/88r9mzoDERHJ0SJfgt+EKoyiUmcQ
 LZDtxrzaIVr26l+xGzSKPRI2km+EfONOF2zA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdif-1ql4sC34Y1-00Ehcv; Thu, 12
 Oct 2023 09:23:25 +0200
Message-ID: <09f4f552-1694-4181-bf63-5482757e5120@gmx.de>
Date: Thu, 12 Oct 2023 09:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/26] spl: Don't cache devices when UNIT_TEST is enabled
Content-Language: en-US, de-DE
To: Sean Anderson <seanga2@gmail.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-17-seanga2@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231012015626.3487451-17-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yh2t/tJIfyXVmxTtEC/ddiqGy2yHE5Uwyt+gtg3k16HDCLaDQxy
 8Vb/1eGzZLrF5ft2cZmTZwArE14kRtTYFEIipYy0l9bGTlcBmgiBN1PkkQmLUgWHR4ygiwA
 TYcX4AdWGZcdHoyxlCsvcu5i4h6KoL/rGpPd586qpduu8ZhQAqa66erBdNb/KCfWeBuzYqj
 hCt+qi/VPC+tAukldTZgg==
UI-OutboundReport: notjunk:1;M01:P0:QT6KkfJi9Cs=;R8skw5gwGx5UfoDjOmZI+l/R2g6
 e1Qm+SB1euIerJ6zKUpg6+hMC+OpdtLDNsyuuaW27mUffzgtqKCh8Mpj5LkKj3hStcPkVw6/J
 u0HzbRbqhbFou+TwKvtsuTdBrse2FgEPvRkDGNSUGXBxNLKwTe5c+0jaVsJfFNbfo95xEOCNz
 Sqm1UV20wQAvxByfipjM2vayYN2mvPi02ir6LLrC/pUG6sJryXd8vnKSDvrMNFMycnm56KbEe
 hvhOaWZW3ja1bnUIGqGefwTtfKideZqhsA6f7uRnoKgVDdkR5035PJr893ggwRhNi4ivnbsUZ
 p/5e+ocJ3IRb4SCyWPbVvjgZI40KWmmjDZagsMY+0WnV/qkp3ecQwM++B+x8iZrWtms00sXDi
 GklEj4DiGaRSUDnp7NwwoGWKrmiQrFTHFtLuw5LjE+P7943dD214L+l86VHtUVJStlQYvKsUd
 nq05Hg9xhKdrOjTQRgfS9Q4v35GM3zEn+Vr7RD1bzQC6BX4uH4WxRxzStfU0WlpBzTy7ME1cA
 fe2U4BWihaQBsGiksoax8UaQ9w6/XcgZKFW4bpv86Stm5agYdVsXrVjsdBfaOmoEIUxNJezNC
 RpHlAwE/QLpjtORQJOaCSbN9yicpHXUcn+bSpJuLuqYjlT/2sEjJmiMVsv9QMAQKqp6aburs+
 0JkCmVQ3gn40UltogZog0NYEJTDYCdA3xtf03sWJLnnbbtmyN0bN7fBDLqcv6rLgA7cF7IxJo
 r8O2jf0SVzeEha18KwCC4qhEoZvOq1KyE+3wsmswCTQ6SkDRPwxlNvwxPu5Q2C3yDEIlWMK6a
 BiNZMu3rbqYlBFBmXiNaKk/MW7UoCeuxEAkhdBOv0lQwtfcOdxr7SYE8mu3Sy2uDlv/Omljsc
 QsKiOHbPgJnkvFyd4jCavyzte+hjX7A+N2YzaWCWr8yOyNBsQ41QyX9y1eoFTX0hLIwYUKYH7
 L3BhM8G/qHXKGJRlbSpqrr4l640=
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

On 10/12/23 03:56, Sean Anderson wrote:
> Several SPL functions try to avoid performing initialization twice by
> caching devices. This is fine for regular boot, but does not work with
> UNIT_TEST, since all devices are torn down after each test. Disable cach=
ing
> so we don't use stale devices.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>   common/spl/spl_fat.c | 2 +-
>   common/spl/spl_mmc.c | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> index c6e2526ade1..8bec9cce5ca 100644
> --- a/common/spl/spl_fat.c
> +++ b/common/spl/spl_fat.c
> @@ -24,7 +24,7 @@ static int spl_register_fat_device(struct blk_desc *bl=
ock_dev, int partition)
>   {
>   	int err =3D 0;
>
> -	if (fat_registered)
> +	if (!CONFIG_IS_ENABLED(UNIT_TEST) && fat_registered)

Please, avoid separate code paths depending on CONFIG_UNIT_TESTS.

We shouldn't change normal behavior if unit tests are not running. It is
preferable to let the unit test framework call a new function resetting
fat_registered when needed. This will allow future tests to test all
code paths separately.

Best regards

Heinrich

>   		return err;
>
>   	err =3D fat_register_device(block_dev, partition);
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 67c7ae34a58..a8579e29dee 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -417,7 +417,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>
>   	/* Perform peripheral init only once for an mmc device */
>   	mmc_dev =3D spl_mmc_get_device_index(bootdev->boot_device);
> -	if (!mmc || spl_mmc_get_mmc_devnum(mmc) !=3D mmc_dev) {
> +	if (CONFIG_IS_ENABLED(UNIT_TEST) || !mmc ||
> +	    spl_mmc_get_mmc_devnum(mmc) !=3D mmc_dev) {
>   		err =3D spl_mmc_find_device(&mmc, bootdev->boot_device);
>   		if (err)
>   			return err;

