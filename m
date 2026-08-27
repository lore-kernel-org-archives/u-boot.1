Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7046C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 09:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97470406A0;
	Thu, 27 Aug 2026 09:01:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WUPXpLgx5Dlo; Thu, 27 Aug 2026 09:01:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787821295;
	bh=4Coz0c/AYJiK6eB3ozdAsrugovwNaFV7N/5eiwP/q2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P6xxtCpj46g61yzGfUTRFK6SsxKUT0mcqZC/5MfkZzWune2LbTJwIISFCAK7jV9zA
	 n1WxSPEdbA7wKWfGXrBlyqUO5a202BPbJZqs0qEDIHIAwJVGzONm39FKTceq2zQe2G
	 YiXIBEuq8XDzCWQfocYvF4LMuCbXzczmSLSmpuj8ee7qnOLVFB5GtQVJ4Wwzn08orH
	 ZRCh5XV391IBVDhg8WrEmUpLtpEqlq/Wg/RzDhsOwar9DpUBRFG6bbwBNPjPnF6gM7
	 H3jhRjqX3+MZhbY6tpZpDKHmYIHJPLdGloKwf0FyeqaRVXqdg0xit3QQtL7uUpfA0Y
	 TMT6je+rfuPtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADCB7406C7;
	Thu, 27 Aug 2026 09:01:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 09AE4105
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3B6580DD7
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:01:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-f4mi-3wFnA for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 09:01:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=L+6lhtuj
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB84480DD4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:01:32 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c25099bb1fbso258610366b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 02:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787821291; cv=none;
 d=google.com; s=arc-20260327;
 b=A/8Nhmt/Wzzg+46dm3NjThbULA+2s1WyVLYIBR2J5Dk0o1aO4aDEWBcwjj75A4K0Tu
 WAykUdoLCPFnA7c2wJFC1eJZ8Y926+HiJEehizBHqHMMCZolrQfhTAlHwbk+90XMZVO/
 lebIokW9i2MclXnHioRe8Vf5oWhvDa7I6QU1DaD6LD0P2oB4G4FGHyukYfdLLpX82lD9
 fk7hFCbzyvOZwKzb5XfsbLOUZArf4lxdNjpVUMx1H30ZQ58A4jDVPKWS6+KhjxHMuEyO
 R1GLvmxa9SYvc73XBfizJUe/XwISAGrvW20yjEa/io6c4fv+2x+NzuzX8t9EvTABWWDv
 GnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4Coz0c/AYJiK6eB3ozdAsrugovwNaFV7N/5eiwP/q2M=;
 fh=vumf0mqCk6H8YX2aAEpypezQN1x39FbS1mPBItTQgOI=;
 b=ZGMP3mdyp7B7ZEIM41clKMLg1PgtfxiEKeoYu3FwhKDmPYM1zm0Em+OVH+ae/pqE0B
 uKdWiIMrwRx/yz70qdNfrpKJk1Qhc+gqiWIXgTb+YifjqjrEQ/hLzD/AOiBWK0wm112G
 HyQEqrqgpQUzZq/lFwtJW8DA4oSOH3wAnLJybfrOtHOnjEwMALlqFaui1DWwG2RUbSVb
 /Nt+Dy1ZmCGhz6vEkK72Q6ihP8NmPXqktVn24NHrcM2/fHA3XbXJLm8yWHG/Se1oTjZ2
 xPzYx79COe5/Al+XlRGRJfetKS7GM93AdypzTOKEod/42DrUu+S1TvSkSPl0I+9BcxT1
 Vmmg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787821291; x=1788426091;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4Coz0c/AYJiK6eB3ozdAsrugovwNaFV7N/5eiwP/q2M=;
 b=L+6lhtujsVZ7mUmDDNMaPu4nvwrCX/U+QY1/qgekVUJSs27fAoBGcBLY6Ng0vwAY8A
 gDByHn6FdRNCp0mFGkxKIoULEprBb5pdJV2TI5hfO8CoECkdwURt4d+CbpMzTX0Qo3zY
 oE8YOI8mklbJh4uzTz5nQhiPqdr4dhs6jYzctotHbon6GLuw9IzEr5j3sHKjfQ6QlU0/
 8p08GOxA4xam65PU+MtZT+pwLvXPAXpW0umdulvhDkIQBMpm0yUW0v6XncGqJss+4TWK
 l86Q9ilM+ukub2u2pNT3j9N3W5FRluabJ+73zpNXjOk5KIFHjQMeDsB0TKv1Ql2h5Iq2
 dBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787821291; x=1788426091;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Coz0c/AYJiK6eB3ozdAsrugovwNaFV7N/5eiwP/q2M=;
 b=U8Xd9lfcN5gATf0vB7CuFfnUYnedxiMy/ngJdMyhbOQek/czKHjwKL1cBMVDtuWg+l
 rDw6awnN+Esk2yBvigDMcea16iC0v/bHAFp+oMRa+X3nwOHcYm/HkWi+MdhREMR743wu
 VXafD0UarEps+mMGfNjaTIBTxqBH9HY2UKWQNPhRYOXj+c51TTFhj4YxJwyqSLtqtWmh
 r+1lRJYzvGoiN28kQ7DTZcp8qwzH8s5T6LVUyDhbs/2KCOtDOGW3qUPQkKztwqvEohUT
 PySdgfGBI4BW4cLbntsm/LJyy7axx5xdbQI1tycbZKxYVr1b1ix2p4qtZhtYnFTCFuSi
 8VBA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoezDYdEN/avVW+ZzwN+9sXJRsvQApIDyK5rSXk9yE64gZoL8Bzr93Hi4Oyj/kHbuVfBkwq02w=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lQGgUoIEda4LDqcnL9yEyOoYP9+m0b4+R2QOdCjvM3jObEb+FT
 n5XnvbLQa+VhcwDGu9Zl/KLncZQ9SD93UiUhylyoevkNsvxNCBINokv8hNdT36qJm17h2MGwoir
 7C2ODZxXTElzC8x88APKPIyTy8//DppEi1nupr6POOA==
X-Gm-Gg: AR+sD13/KmVtuykzXymmQaj4OGOTIIMYBetBxomJbXnkfQVXR5xSEKlnzctNxpttXAy
 8Q48UpTTiuycF4Tt/g+2MYv3t6u/nbOV1OjpYF7y+srDJmJt2leGDl8z3EtG9xqyQwOU6J6OS4s
 +vjbKpqLNHWEv4wGhwRaTILn3ehz8cPF+MbLQ9Rw3BKTDN7i7xPLF6389czVwPXxn+bdEi33cfT
 MJHsz1f2hoJHKKJsqflULhwTZIBcWnn5Egp++PbgFcVRbl8OAvEY+Fn6mDUe8twNu/8OsHLB8Md
 U7o2Nsi/PjtbGaUODX21urxVvUR5brXMgG6ELDO6AWgyNnGIM9t+qQdi3WI9G0Qsak9KGdQRqxe
 TH8XXZnzc5Yg=
X-Received: by 2002:a17:907:e1c5:10b0:c25:32ae:a6e4 with SMTP id
 a640c23a62f3a-c2532aeb691mr479891666b.9.1787821290867; Thu, 27 Aug 2026
 02:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-5-a3f1f16b53ae@flipper.net>
 <92d57391-aa91-4900-b36b-dea5b85e9694@canonical.com>
In-Reply-To: <92d57391-aa91-4900-b36b-dea5b85e9694@canonical.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 27 Aug 2026 13:01:22 +0400
X-Gm-Features: AcwNN1VRTrX48NRkIApkvFdl1XTk2jxfP2lVP9OIHOhf92-QOyNTbE0ZVnkyf4w
Message-ID: <CAKTNdwF6p-to_zwXfwO17GL8SP6q8BsSb5g69O6_aW8hz8TSjA@mail.gmail.com>
Subject: Re: [PATCH 5/6] test: py: gpt: Bind the disk image in
 test_gpt_write_part_type()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>, 
 Javier Martinez Canillas <javierm@redhat.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Klaus Goger <klaus.goger@cherry.de>,
 Tim Lunn <tim@feathertop.org>, u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
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

On Wed, Aug 26, 2026 at 1:41=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 7/31/26 14:40, Alexey Charkov wrote:
> > Unlike every other test in this file, test_gpt_write_part_type() never
> > binds the disk image it operates on. It has worked since it was added
> > only because some test that ran before it left host 0 bound to the
> > image this fixture provides.
> >
> > That breaks as soon as a test which binds something else is added
> > above it, and it means the test silently depends on collection order
> > rather than on its own fixture. Bind the image like the other tests do.
> >
> > Fixes: 7a598e633a53 ("test/py: tests: gpt: add test_gpt_write_part_type=
")
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   test/py/tests/test_gpt.py | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
> > index e6d8792ac1fc..fb4c8ba67d48 100644
> > --- a/test/py/tests/test_gpt.py
> > +++ b/test/py/tests/test_gpt.py
> > @@ -338,6 +338,7 @@ def test_gpt_write(state_disk_image, ubman):
> >   def test_gpt_write_part_type(state_disk_image, ubman):
> >       """Test the gpt command with part type uuid."""
> >
> > +    ubman.run_command('host bind 0 ' + state_disk_image.path)
>
> The "0" in the `host bind 0` command is not the device number but a
> label. If a prior `host bind` command used a different label your device
> "0" may not have device number 0 as assumed below.
>
> Here is an example:
>
> =3D> host bind 1 ../sandbox.img
> =3D> host bind 0 ../sandbox.img
> =3D> host info
> dev       blocks  blksz label           path
>    0       131072    512 1               ../sandbox.img
>    1       131072    512 0               ../sandbox.img

Wow, that's very intuitive indeed :-D

> Each test that uses host bind should unbind the device at the end of the
> test. This also applies to test_gpt_write_part_type().

Added an unbind in my newly introduced test in v2. Shall I produce a
separate patch to add unbind in the other tests here? Or wait for your
patch to get merged, so that the tests can be converted to take the
device number from a variable instead of hardcoding 0?

> For reliable testing we need a host sub-command that writes the
> device-number (dev_seq(dev)) for a label to a variable. We should extend
> the `host info` command for this purpose:
>
> [PATCH 1/1] cmd/host: allow to retrieve sequence number for label
> https://lists.u-boot-project.org/pipermail/u-boot/2026-August/629880.html

Best regards,
Alexey
