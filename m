Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1704AC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 15:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E6B784B32;
	Fri, 10 Jul 2026 17:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/18CKnj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C78184B2B; Fri, 10 Jul 2026 17:16:44 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E925D84B4C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naveen.osdev@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc7so507187b3a.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783696600; x=1784301400; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xYQOb8b6JcuE/L/VkePl4CFSWOwZ/jq3mQOWmhmnwSk=;
 b=T/18CKnjF0PSpNZMIpWSuFQUYF//D5Lmx8/U9I+VED/zmvMo/LhGRREzaMXlm2THft
 PaRnbuPSQ2eNhTvfjdOZXo+sgUMxtzGeCNQN0S7Po21UYE55vWWSooDOiq9bQUGd865k
 /IhNZpfo+nGeYRlSG/dPcHB6qLDwFrrp1VIkOEp140NrH3O2lws5UmBm0P7vol3+JBE1
 ntP7by0L8jCPji4mJv+8DXeh8oOLiyJB8TIynJAmptPlNAUSDniarAMnJRmqgxbwCPrM
 PCCusNma2ecsvjIJlybM3srrV4yoCJuPlVOtCxfGKyG4w/KRUisbvuovMvpwx5rh6wsB
 Yj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783696600; x=1784301400;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xYQOb8b6JcuE/L/VkePl4CFSWOwZ/jq3mQOWmhmnwSk=;
 b=G+ELe+a91gVsjHpSRQDotn+YoOekDXHZgwiU09kmo1D8Hsq1yyZpZhRsdNxMccZ/zx
 tcUiVPTXxALLGfTxjSxrSLzvTijscem2H1GaWTrW03kgii5GvqjGxpluyKVlws2LTv9y
 uBrcG8jX9T5+OcpSl9Tkv+LggR7/iNuXPfQeYRiYUWaqW5tFBEXOOy8sBZUvx1cyq40k
 jZsltKtp3JKNeU3ian5CjPdDUZUx+ZE3gqD+e9OXfsZHSTLiVvFeAJSCFMYkY0O6I5an
 t8bFtF/ENkQuaakRxrdJlNNqxvuhJKjVJVCF7dmqlOU1qILIMsfpP9urxu3eljr9XDQu
 FA4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1zRFomq8u3aEt6uC8PD0F9352p6RKOkbtePHkilJRwCpHAbDTYc9cS8oKHhI68zF79KJvNLQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyv8uv0e8mJiBhFV8JD6WbWCBDllubOr20nuRJScOoqoYBWPPsi
 N5mMz2QSW+NiiaDV5TLxNMVp+Iqr0gj9ob5EMLjqb8T1DFQgrSG6BN5ze/KcRw==
X-Gm-Gg: AfdE7cmSFxo9P6+N5H1Ultu5SXgNudlMwrDb21P+WPWUe2n4dGnh0SXs09AGj7pfQUW
 gxnhzbk3mIpU6dwL3N5/CbLqP6MKhGVCQ7L5wKd5K/xDACbxEkUto1wh9Q52je3Aez3kxYAGrm/
 mqH1qJvL8RnJnKwLSsQ663NoszhoRPmuLmWX56Gk632WqVNlL+iDT1HN9ARXr4GimfdI6e/AbT5
 FnjFgjQj5GJl8UN124Wujk/yNGiwTeJLb2yYyrpllFycbP7Av9UyY9/B/r4ZnJqCJq9mvi0TU1H
 UM0OY++L/P3LSI1kkLBDVE366FljshAk9fLTZEfgAx5MSGDHFEPfMtd5KTEWZ81+PTEroYUcNmX
 Ziej22o02g4pD9hec+bSoA2ribIN7o5vA685jbnpW6LZxYUciKUecogJcfDtlKgD26avh2qaULq
 V7lVmdU1a4bg==
X-Received: by 2002:a05:6a00:3e12:b0:848:3dae:66e2 with SMTP id
 d2e1a72fcca58-84842ee541bmr11174415b3a.26.1783696599891; 
 Fri, 10 Jul 2026 08:16:39 -0700 (PDT)
Received: from localhost ([49.36.187.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6db0eaasm10415629b3a.52.2026.07.10.08.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:16:39 -0700 (PDT)
Date: Fri, 10 Jul 2026 20:46:37 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: led: reject unknown LED state instead of silently
 returning success
Message-ID: <za2nl6cv6cpqajy25eb2y5nvin2o6rkxotiussamspnvsdze5f@aq6ebysavqth>
References: <ifny32czr2jodibz3wyerwqfjzbepdkt3tfhvgw5qp6ymm736m@kmqqewswdxqq>
 <b6336f00-4c3f-4cde-9702-353bf9a0f7fd@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6336f00-4c3f-4cde-9702-353bf9a0f7fd@cherry.de>
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

After the commit 72675b063b6e changed led states to an enum, I honestly
don't see any problem (others can correct me). The current
implementation is more readable than if-else ladder, specially when the
list grows for whatever reason.

However, thanks to your comment, I went through the implementation once
more and found that the below define in led.c seems leftover and buggy
to me and needs to be removed :

#define LED_TOGGLE LEDST_COUNT

Thoughts?

Regards,
Naveen

On Wed 08 Jul 06:00 PM, Quentin Schulz wrote:
> Hi Naveen,
> 
> On 7/8/26 4:32 PM, Naveen Kumar Chaudhary wrote:
> > get_led_cmd() searches state_label[] for a matching name and returns
> > -1 on no match, but its declared return type is enum led_state_t.
> > All enumerators of that enum are non-negative, so the compiler is
> > free to pick an unsigned underlying type (and does so with
> > -fshort-enums, which several U-Boot targets enable). In that case
> > -1 is reinterpreted as a large positive value and any subsequent
> > comparison against -1 silently misbehaves.
> > 
> > In do_led() the returned value is stored into an enum led_state_t
> > and dispatched through a switch that has no default arm and no case
> > for the sentinel. When the user supplies an unknown state name the
> > switch falls through, ret was already set to 0 by led_get_by_label(),
> > and the command reports success without doing anything.
> > 
> > Return LEDST_COUNT from get_led_cmd() on no match. LEDST_COUNT is
> > already a valid enumerator, so this avoids all questions about the
> > enum's underlying representation. In do_led(), when a state argument
> > was actually supplied (argc > 2) and the lookup produced LEDST_COUNT,
> > reject it with a diagnostic and CMD_RET_USAGE; the existing
> > LEDST_COUNT switch arm continues to handle the "no state argument"
> > case where it means "show current state".
> > 
> 
> That looks correct to me, but I think get_led_cmd() is overengineered and
> actually still flawed. Indeed, we iterate up to LEDST_COUNT-1 times on the
> state_label[] array, but nothing guarantees the array is that big (it is
> right now) so we could theoretically have out-of-bounds access in the
> future. It also isn't handling the case when there's no matching string at a
> given index (e.g. holes in the array or padding at the end due to the last
> element in the array not being LEDST_COUNT-1), where state_label[i] would be
> NULL and strncmp doesn't seem to be handling that case (it isn't in
> lib/string.c for example).
> 
> I think the answer is to instead get rid of this and drastically simplify.
> 
> Remove get_led_cmd() and state_label[] and do something like the following
> in do_led() (NOT TESTED):
> 
> """
> diff --git a/cmd/led.c b/cmd/led.c
> index 296c07b3b38b..d1fc9dc8cdbd 100644
> --- a/cmd/led.c
> +++ b/cmd/led.c
> @@ -9,27 +9,6 @@
>  #include <led.h>
>  #include <dm/uclass-internal.h>
> 
> -#define LED_TOGGLE LEDST_COUNT
> -
> -static const char *const state_label[] = {
> -	[LEDST_OFF]	= "off",
> -	[LEDST_ON]	= "on",
> -	[LEDST_TOGGLE]	= "toggle",
> -	[LEDST_BLINK]	= "blink",
> -};
> -
> -enum led_state_t get_led_cmd(char *var)
> -{
> -	int i;
> -
> -	for (i = 0; i < LEDST_COUNT; i++) {
> -		if (!strncmp(var, state_label[i], strlen(var)))
> -			return i;
> -	}
> -
> -	return -1;
> -}
> -
>  static int show_led_state(struct udevice *dev)
>  {
>  	int ret;
> @@ -83,12 +62,24 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc,
> char *const argv[])
>  	if (strncmp(led_label, "list", 4) == 0)
>  		return list_leds();
> 
> -	cmd = argc > 2 ? get_led_cmd(argv[2]) : LEDST_COUNT;
> -	if (cmd == LEDST_BLINK) {
> +	if (argc == 2) {
> +		cmd = LEDST_COUNT;
> +	} else if (!strncmp(argv[2], "off", strlen(argv[2]))) {
> +		cmd = LEDST_OFF;
> +	} else if (!strncmp(argv[2], "on", strlen(argv[2]))) {
> +		cmd = LEDST_ON;
> +	} else if (!strncmp(argv[2], "toggle", strlen(argv[2]))) {
> +		cmd = LEDST_TOGGLE;
> +	} else if (!strncmp(argv[2], "blink", strlen(argv[2]))) {
>  		if (argc < 4)
>  			return CMD_RET_USAGE;
> +
> +		cmd = LEDST_BLINK;
>  		freq_ms = dectoul(argv[3], NULL);
> +	} else {
> +		return CMD_RET_USAGE;
>  	}
> +
>  	ret = led_get_by_label(led_label, &dev);
>  	if (ret) {
>  		printf("LED '%s' not found (err=%d)\n", led_label, ret);
> """
> 
> What do you think?
> 
> I wouldn't necessarily add a printf for when the user mistypes, just return
> CMD_RET_USAGE where we list what's possible. If you really want to keep it
> at least replace "state" with "operation" as it's something we do on the LED
> not its state (e.g. one can request "toggle" which definitely isn't a
> state).
> 
> Please also add
> Fixes: ffe2052d6e8a ("dm: led: Add a new 'led' command")
> 
> to your commit log also as that's the commit introducing the error.
> 
> Cheers,
> Quentin
> 
> > Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> > ---
> >   cmd/led.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/cmd/led.c b/cmd/led.c
> > index 296c07b3b38..d547276e480 100644
> > --- a/cmd/led.c
> > +++ b/cmd/led.c
> > @@ -27,7 +27,7 @@ enum led_state_t get_led_cmd(char *var)
> >   			return i;
> >   	}
> > -	return -1;
> > +	return LEDST_COUNT;
> >   }
> >   static int show_led_state(struct udevice *dev)
> > @@ -84,6 +84,10 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >   		return list_leds();
> >   	cmd = argc > 2 ? get_led_cmd(argv[2]) : LEDST_COUNT;
> > +	if (argc > 2 && cmd == LEDST_COUNT) {
> > +		printf("Unknown LED state '%s'\n", argv[2]);
> > +		return CMD_RET_USAGE;
> > +	}
> >   	if (cmd == LEDST_BLINK) {
> >   		if (argc < 4)
> >   			return CMD_RET_USAGE;
> 
