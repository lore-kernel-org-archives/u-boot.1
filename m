Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5225EC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 13:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF1C88A37;
	Wed, 31 Jul 2024 14:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=comcast.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=comcast.net header.i=@comcast.net header.b="1/ZbEFzW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F9F889D5; Wed, 31 Jul 2024 14:27:52 +0200 (CEST)
Received: from resqmta-c2p-570217.sys.comcast.net
 (resqmta-c2p-570217.sys.comcast.net [IPv6:2001:558:fd00:56::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D39B588970
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 14:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=comcast.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fventuri@comcast.net
Received: from resomta-c2p-555662.sys.comcast.net ([96.102.18.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
 (Client did not present a certificate)
 by resqmta-c2p-570217.sys.comcast.net with ESMTPS
 id Z77ds4KhgcrjXZ8Qls2fi7; Wed, 31 Jul 2024 12:27:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1722428867;
 bh=t/lNQ85mXbKpo4NdfS6j55omkwIcWSYkbb3UXVCN/Lw=;
 h=Received:Received:Date:From:To:Message-ID:Subject:MIME-Version:
 Content-Type:Xfinity-Spam-Result;
 b=1/ZbEFzW16hmw6m8sU9jSK2eqkesvLSrrnGHRTo4TdSE09EcvIKv2HkecqA8YRmGx
 EAO8vkr2dXoOD+toEytHNvT52eitITW4gE2eBF/Fx9rFjW2jma4Jz2wqs40u2VhnXM
 Kbdocjq5TvC0hDDpX1eXcbWxqo2LO3UT7XHLA4MjrgpsVKPcCUWjKN/sAQWKOPFoYW
 YCbukGrFuzbj8G+D8MRGPfAmB/YabI2kbUUA9NaBiMlQYnA7AHCO8o9jH4ocTFN3lW
 Z5UpjWuh+EqjY3dDRG44OLidm2IZTvot2c4fud9Y+B4ZRStqjkNlzUV5jy247WkF9g
 OkjOL8Nhu1ElA==
Received: from oxapp-ch2f-71o.email.comcast.net ([96.117.87.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
 (Client did not present a certificate)
 by resomta-c2p-555662.sys.comcast.net with ESMTPS
 id Z8QOsjcLbkhVgZ8QOst9RE; Wed, 31 Jul 2024 12:27:25 +0000
Date: Wed, 31 Jul 2024 08:27:24 -0400 (EDT)
From: Franco VENTURI <fventuri@comcast.net>
To: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Message-ID: <943273390.259506.1722428844223@connect.xfinity.com>
In-Reply-To: <DB9PR04MB8461F1E0FC7BC664F4924C0788B02@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240730133043.12577-1-fventuri@comcast.net>
 <DB9PR04MB8461F1E0FC7BC664F4924C0788B02@DB9PR04MB8461.eurprd04.prod.outlook.com>
Subject: RE: [PATCH v1] mmc: fix signed vs unsigned compare in read check in
 _spl_load()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev59
X-Originating-IP: ::ffff:76.18.214.183
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4xfHs74ImR7so9fF+d+beGjRY1xg3sfeeKEoA2HeeAidH3pjkwIHygTtvcksLg7fGGJ5MO9pRJyFO7kdCWsgt2qjTKrPuAuhCmU55rrnwrwxZDn9PUinEX
 wJLOReQuVuv4eQzMzU60/XNqrNw03I5lK6LSShJYyoAR/LZmia/9aC6qSKgddu8+BieyRrQh/uWrtXUfL6mQOlEi95jPcFwsLuOSeioD+1B8FE2yvAjSc/+Y
 ba1Fst3x2HeAypBI/RvoackWu7K8+SxZfOiSFANarB7YlcsJ9L+huoewulfnbrZRmMPYhX34Uz0+mEqzhCQ6cZhYvll3k0OutWrhvxN2VfXvyonL/l9SGJDh
 K9MY5z0K
X-Mailman-Approved-At: Wed, 31 Jul 2024 14:59:20 +0200
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

Peng,
no, with just the condition 'read < sizeof(*header)', the variable 'read' (which is a signed integer) will be converted ('balanced') to unsigned to match the type of 'sizeof()' as per the C standard specification (see https://stackoverflow.com/a/17294164).

This means that a value read = -2 will be converted to unsigned  0xFFFFFFFE, the comparison 'read < sizeof(*header)' will be false, and the _spl_load() function will not return -EIO

In order to fix this bug one has to check first if the value of 'read' is negative *and* then check 'read' against 'sizeof(*header)'.


To better explain this bug, this morning I wrote the following small C program:


int main()
{
    int read = -2;
    typedef struct {
        int a;
        int b;
        int c;
    } header_t;
    header_t hdr;
    header_t *header = &hdr;

    printf("case 1 - read < sizeof(*header)\n");
    if (read < sizeof(*header)) {
        printf("would return -EIO\n");
    } else {
        printf("would continue\n");
    }
    printf("\n");

    printf("case 2 - read < 0 || read < sizeof(*header)\n");
    if (read < 0 || read < sizeof(*header)) {
        printf("would return -EIO\n");
    } else {
        printf("would continue\n");
    }
    printf("\n");

    printf("case 3 - read < (ssize_t)sizeof(*header)\n");
    if (read < (ssize_t)sizeof(*header)) {
        printf("would return -EIO\n");
    } else {
        printf("would continue\n");
    }
    printf("\n");

    return 0;
}

When I run this program, this is the output:

case 1 - read < sizeof(*header)
would continue

case 2 - read < 0 || read < sizeof(*header)
would return -EIO

case 3 - read < (ssize_t)sizeof(*header)
would return -EIO



Hope this makes sense,
Franco

> On 07/30/2024 9:45 AM EDT Peng Fan <peng.fan@nxp.com> wrote:
> 
>  
> > Subject: [PATCH v1] mmc: fix signed vs unsigned compare in read
> > check in _spl_load()
> > 
> > Fix signed vs unsigned compare in read check in _spl_load()
> > 
> > Issue: when info->read() returns a negative value because of an error,
> >        the comparison of 'read' (signed) with 'sizeof(*header)'
> >        (unsigned silently converts the negative value into a very
> >        large unsigned value and the check on the error condition
> >        always return false, i.e. the error is not detected
> > Symptoms: if spl_load_image_fat() is unable to find the file 'uImage',
> >           the SPL phase of the boot process just hangs after displaying
> >           the following line:
> >           Trying to boot from MMC1
> > Fix: first check if 'read' is negative then check its value against
> >      'sizeof(*header)'
> > Reference:
> > 
> > Signed-off-by: Franco Venturi <fventuri@comcast.net>
> > ---
> > 
> >  include/spl_load.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/spl_load.h b/include/spl_load.h index
> > 1c2b296c0a..1e05599d29 100644
> > --- a/include/spl_load.h
> > +++ b/include/spl_load.h
> > @@ -22,7 +22,7 @@ static inline int _spl_load(struct spl_image_info
> > *spl_image,
> > 
> >  	read = info->read(info, offset, ALIGN(sizeof(*header),
> >  					      spl_get_bl_len(info)),
> > header);
> > -	if (read < sizeof(*header))
> > +	if (read < 0 || read < sizeof(*header))
> 
> "read < 0" will imply that "read < sizeof(*header)", so there
> should no need to include this change.
> 
> Regards,
> Peng.
> 
> >  		return -EIO;
> > 
> >  	if (image_get_magic(header) == FDT_MAGIC) {
> > --
> > 2.45.2
