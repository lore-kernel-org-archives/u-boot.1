Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093FBCD1296
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 07:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 236FD87FB5;
	Mon,  8 Apr 2024 09:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="jEtEv+a3";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/Ce/TLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCED887FB5; Mon,  8 Apr 2024 09:47:12 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E5FE87CAC
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 09:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id 2E797180013B;
 Mon,  8 Apr 2024 03:47:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 08 Apr 2024 03:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1712562421; x=1712648821; bh=2V1cKR1YYU
 qfhTk98dY02e+rk+HOjmxzlVFveK4tfEQ=; b=jEtEv+a33P+zA+uoZ5QhwdytVy
 OCUHb3Xz2bj8jCrBfPEsqbT+jhAl0YKx16C4WC3Mpto1vLDfc/MNJgdBcRBRVMY7
 U3CrtxH8HpKmjC0CZHfaVvKKV03W0iooK5CAED0uo1eLQkVZW4hqX/aAuhyDArOF
 aONIIIDvA6pV2PCMQluwFXnUaemh6bkCRUnsdODtoNyRjiwGG8m+cqcoighjTAK/
 QbrMQcod99SaxuXs2dyTzf/CBEM0lV5uRBi2m4dr4WEexoGn98IfajNPg4iQISzr
 7l80ZRmRVV/ncp3CIuRq9LycomZAwd9ck9w5WWzouK8OXuMl7VzZtlRyUx3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712562421; x=1712648821; bh=2V1cKR1YYUqfhTk98dY02e+rk+HO
 jmxzlVFveK4tfEQ=; b=U/Ce/TLhi2wwnMp6WRms61aNikhtk0rhgMnTxwi6tCOj
 roHkIqGAiNXebhh8WruTLolpQ1rT8epnlaVyM3WDzuDFQhOVs097GBvpKc2JNwXi
 V4pbhQMl4pYnCwWeWK3CNffDps5NDT8Px2Harn2doDdux4kclTRsQDSgxwrbM/jm
 NKzo5XmYcN3Hhbmhvhgdf+Qx7uyRUPCvB1+TlOi4MiOLWCDhIDfhDsqW6oiieDE9
 v4F4ObuJusRBphRhya42ifEaf2fMzguQ72B9yFMhwVrKWQ+DuL+VOiLpLUbkXIAo
 sEfEMn23ioH8hAl3Ih0p6om1ryInwden9GkOfxW6Fw==
X-ME-Sender: <xms:9aATZh6xDdONexu-PitjrIBzfmmXhGzzYPVslGr05Ym8ABgexaH7AQ>
 <xme:9aATZu55k70XVwQXSQD5rdO2-pXmVg1tXHZj31CSM7NgX_fGCo5SqZ7iC2PzR_Q7L
 mHh7Vp1eIaUNmKnrDs>
X-ME-Received: <xmr:9aATZocWH_r_8ZgTJusU_Jfx_vbpPwJp1X_miLxjOoL5kXPSKM_F3lAEjxch2_hOMRmIkX40UztBuOURcWFlAOqvk3pgsXXBAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddvvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehmtderredttdejnecuhfhrohhmpeflrghn
 nhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnh
 epgfekveetieelgeefkefhueelueegvddtuefhudeuffeigeeutdfgiefffefhkeegnecu
 ffhomhgrihhnpeguvghngidruggvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:9aATZqJN0YhIr5V3n5MvDZur2tSPB5rTRkZBFU_UKe4C-RFMS1YqsA>
 <xmx:9aATZlJeeZb_kdifOUFOAWP5iP-crIrg65lDurW16uVhQ2vSeO4kEA>
 <xmx:9aATZjxx6awxrh-BWt-ccZAWR-2mZGuZMCZtYKGrU0S2a1IauyUF-g>
 <xmx:9aATZhKwDjm8qyK6sAslpRLHxMXHyElZpS_EEC_tMDDtM2irPQgCbg>
 <xmx:9aATZs-u7Mxkk77A8XlQb7_0Tz_Znc9a0vN1GK6C-XTiOG4_4MheLB29>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 03:47:00 -0400 (EDT)
Date: Mon, 8 Apr 2024 09:46:59 +0200
From: Janne Grunau <j@jannau.net>
To: Marek Vasut <marex@denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de,
 asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v4 0/6] USB keyboard improvements for asahi / desktop
 systems
Message-ID: <ZhOg81sBEDLgCSIa@robin>
References: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
 <356b892a-a681-4ae0-a6c8-ed1b4b5a8717@denx.de>
 <ZhBLfQfxB_UEwvyY@robin>
 <5467f380-de35-4776-8c32-90b8e08aeda7@denx.de>
 <ZhGq0U_pkrYMe4S1@robin>
 <5ed4e6d2-edc7-461d-8183-e91d7b994aa5@denx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WP5wpjb+r9JLJshy"
Content-Disposition: inline
In-Reply-To: <5ed4e6d2-edc7-461d-8183-e91d7b994aa5@denx.de>
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


--WP5wpjb+r9JLJshy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sun, Apr 07, 2024 at 03:05:59AM +0200, Marek Vasut wrote:
> On 4/6/24 10:04 PM, Janne Grunau wrote:
> > On Sat, Apr 06, 2024 at 08:52:17PM +0200, Marek Vasut wrote:
> >> On 4/5/24 9:05 PM, Janne Grunau wrote:
> >>> On Fri, Apr 05, 2024 at 04:52:32PM +0200, Marek Vasut wrote:
> >>>> On 4/4/24 8:25 AM, Janne Grunau via B4 Relay wrote:
> >>>>> Apple USB Keyboards from 2021 need quirks to be useable. The boot HID
> >>>>> keyboard protocol is unfortunately not described in the first interface
> >>>>> descriptor but the second. This needs several changes. The USB keyboard
> >>>>> driver has to look at all (2) interface descriptors during probing.
> >>>>> Since I didn't want to rebuild the USB driver probe code the Apple
> >>>>> keyboards are bound to the keyboard driver via USB vendor and product
> >>>>> IDs.
> >>>>> To make the keyboards useable on Apple silicon devices the xhci driver
> >>>>> needs to initializes rings for the endpoints of the first two interface
> >>>>> descriptors. If this is causes concerns regarding regressions or memory
> >>>>> use the USB_MAX_ACTIVE_INTERFACES define could be turned into a CONFIG
> >>>>> option.
> >>>>> Even after this changes the keyboards still do not probe successfully
> >>>>> since they apparently do not behave HID standard compliant. They only
> >>>>> generate reports on key events. This leads the final check whether the
> >>>>> keyboard is operational to fail unless the user presses keys during the
> >>>>> probe. Skip this check for known keyboards.
> >>>>> Keychron seems to emulate Apple keyboards (some models even "re-use"
> >>>>> Apple's USB vendor ID) so apply this quirk as well.
> >>>>>
> >>>>> Some devices like Yubikeys emulate a keyboard. since u-boot only binds a
> >>>>> single keyboard block this kind of devices from the USB keyboard driver.
> >>>>>
> >>>>> Signed-off-by: Janne Grunau <j@jannau.net>
> >>>>
> >>>> I picked the series, but CI indicates build errors, can you have a look ?
> >>>>
> >>>> https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/20215
> >>>
> >>> The issue seems to be that the field dev in struct usb_device exists
> >>> only for DM_USB. That means we can't use dev_dbg.
> >>> Either take the following fixup patch or I can resend the series.
> >>
> >> I squashed the extra patch in, but I think the CI still complains:
> >>
> >> Pipeline #20236 (
> >> https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/20236 )
> >> triggered by Marek Vasut ( https://source.denx.de/marex )
> >> had 1 failed job.
> >>
> >> Job #812215 (
> >> https://source.denx.de/u-boot/custodians/u-boot-usb/-/jobs/812215/raw )
> > 
> > env_get() missing without CONFIG_ENV_SUPPORT. I'm too accustomed to the
> > kernel's stub functions. Best option seems to to just #if the
> > functionality out in this case. See attached fixup patch.
> > 
> > Sorry,
> 
> No worries.
> 
> Does it work if you do this instead ?
> 
>   static int usb_device_is_ignored(u16 id_vendor, u16 id_product)
>   {
>          ulong vid, pid;
> +       /* No env support, nothing can be ignored */
> +       if (CONFIG_IS_ENABLED(ENV_SUPPORT))
> +           return 0;
> 
> That way, the function is always compiled and if it is unreachable, then 
> compiler throws it out. This should improve code compile coverage.

Seems to work here with a broken imx8 config from the CI. Is it ok to
rely on dead code elimination? Apparently it is, build with KCFLAGS=-O0
has already several other missing symbols.

See attached fixup

Janne

--WP5wpjb+r9JLJshy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline;
	filename="0001-fixup-usb-Add-environment-based-device-ignorelist.patch"

From ab3b825d7bc0571cfb38eb80a1e449e51d5d2f6d Mon Sep 17 00:00:00 2001
From: Janne Grunau <j@jannau.net>
Date: Mon, 8 Apr 2024 09:44:54 +0200
Subject: [PATCH 1/1] fixup! usb: Add environment based device ignorelist

---
 common/usb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/usb.c b/common/usb.c
index 8bc85c58b28c..99e6b857c74c 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -1089,7 +1089,13 @@ static int usb_device_is_ignored(u16 id_vendor, u16 id_product)
 {
 	ulong vid, pid;
 	char *end;
-	const char *cur = env_get("usb_ignorelist");
+	const char *cur = NULL;
+
+	/* ignore list depends on env support */
+	if (!CONFIG_IS_ENABLED(ENV_SUPPORT))
+		return 0;
+
+	cur = env_get("usb_ignorelist");
 
 	/* parse "usb_ignorelist" strictly */
 	while (cur && cur[0] != '\0') {
-- 
2.43.2


--WP5wpjb+r9JLJshy--
