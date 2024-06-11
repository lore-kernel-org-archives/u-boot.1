Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A12AC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E439188730;
	Tue, 11 Jun 2024 22:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OZltEeEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E8588871A; Tue, 11 Jun 2024 22:07:42 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45FBC88617
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-43ff9d1e0bbso29390601cf.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136457; x=1718741257; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V3NuNAiBsU/Nco8BbJ7fw0wQyBut4C7Jfk+KMVpyzlk=;
 b=OZltEeECApGEB7jtFpRFOW8XcxkaCOsLWvG7mY6GxAihouRMfhUaiKA+sgmBc2BmS6
 M8inSmtCktIfzRVJmYNTd06Fn3GKawnftp32MUUYLJ2ddrpXwtIqP6i/IoTgK0xqzGXP
 +6nm1OXASyeDyYwLc31VCWfXJvZqzHiyRME2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136457; x=1718741257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V3NuNAiBsU/Nco8BbJ7fw0wQyBut4C7Jfk+KMVpyzlk=;
 b=dsWCz1vS3lJ/OBNKcVOjwE+9wqNRSrk+rfOmE2XlgaSTKAH7oo9L0aATYcUrzHyT2u
 PkUr8zN/NOQUJYEXvyFuQnwOkw5Cu93fjYsT62mTAp+DSIPkE6rVuJTqOruLnd5yexQE
 +yDuNh7rUESWHfrBYeo6VqZqRAr3SODcTL13MCNYFfGDSt7jf2vkLJ/E26OMq338c9EJ
 BHoXkfbCRI0PN10wDw7JdM7At0qdo1s2biwxfDwW1p/AGK+mmxzX9l1RFOcnKwdacdRq
 t4WHSnmTU47heZxx859mdo6jG53i5qTPtqkkHBFNGToiSyHA6poTDyfhAqo4EcQ542EF
 PY7A==
X-Gm-Message-State: AOJu0YzG3wuua/Y7E0P5xksIDFWp88sVvhIUt1Kz0jp6hZFfhOa0qgpQ
 +p/ddW0SfPPAMQ/7TiNifhRpdCymKzeZlHHNTz5TrgmoFAMsdVxaVQYTGpIkoOY67uM3IG4HEwY
 1lfaRSwMKaEYx7IUixGPTpWYl2TtVKQJh9PdPchV/uNl4sRr4Tg==
X-Google-Smtp-Source: AGHT+IEM1NVM8pQ9cWwQGtESFKcUVEe3MSd/ENSWxbEWFrCrXOsGfmlb7vXrFMlTWV8ryxMF42y8NaiuWibe1gQ66Aw=
X-Received: by 2002:a05:6214:460c:b0:6b0:64bd:c4aa with SMTP id
 6a1803df08f44-6b064bdc5f8mr139415856d6.9.1718136457148; Tue, 11 Jun 2024
 13:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240610222743.255386-1-sjg@chromium.org>
 <20240610222743.255386-2-sjg@chromium.org>
 <20240611160730.GJ68077@bill-the-cat>
In-Reply-To: <20240611160730.GJ68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 14:07:26 -0600
Message-ID: <CAFLszTjk894twWPzfX-=Xw06Z6f2hjdxDguinBxAQhmjQ7KYNQ@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH 1/2] Create a common file for test
 scripts
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Tue, 11 Jun 2024 at 10:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jun 10, 2024 at 04:27:42PM -0600, Simon Glass wrote:
>
> > The top part of each of the u-boot-test-* files is common. Put it in
> > a common script file to avoid duplication and to allow it to be
> > replaced for the Labgrid integration.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> [snip]
> > +++ b/bin/u-boot-test-common
> [snip]
> > +bin_dir="`dirname $0`"
>
> So we always set bin_dir here...
>
> > +board_type="$1"
> > +board_ident="$2"
> > +hostname="`hostname`"
> > +
> > +. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
> > diff --git a/bin/u-boot-test-console b/bin/u-boot-test-console
> > index 0b6b4ac..ad90040 100755
> > --- a/bin/u-boot-test-console
> > +++ b/bin/u-boot-test-console
> > @@ -20,12 +20,7 @@
> >  # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> >  # DEALINGS IN THE SOFTWARE.
> >
> > -set -e
> > -
> >  bin_dir="`dirname $0`"
>
> But never remove it from the other files.

Yes that was my intent, but then I realised that it is used in
u-boot-test-console, then wasn't sure it was a win...

Perhaps I could do this in each script?

. "$(dirname $0)/u-boot-test-common"

and that would allow removing bin_dir. The above is pretty clear.

Regards,
Simon
