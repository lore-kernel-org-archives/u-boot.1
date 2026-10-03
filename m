Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BB1CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A3494134B;
	Sat,  3 Oct 2026 13:03:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YqD6k9g-WqD7; Sat,  3 Oct 2026 13:03:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6603F41350
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032586;
	b=Lbdev+iSoq6vcu+AZLmik2RB2XM0v30/E7bNJPdD8Cu717oh3bMMnZKpeF0w68xUnKGC
	 WIrlBhYDNyEKjbIPvcc1NoTGlqZG1xKG8QaxaLXQnHW6ddwArGDPNzgjd1BqJRUJ5uTPm
	 xvpXnRKta4/dars31ptIBDii9JEjfCwvFgOZbZnlj4La6lgy+xg8bLKxSjKxfzzjDKIUZ
	 IrCs1OwuIRPsKPwYpHPVKqqoY5wml+5iOXtWysIc5ywd/65MiQohMNvnTGuVJ1Jvi5DS+
	 ep+d6dV92uoVf6SI05aR0Fge/LHadGzAB0B09ZRpW8yWzTXxHWb+fkkEpjbIswhpjIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791032586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5vYWYhxU4xQfKWsjDQOb7SeHvjc62LEH9P0VQ0LIF0A=;
	b=Voij3C9AtczqbOTOWtNYbzfeS+rcn1e90LBTSXQOYbhPMjG4NIDpJY6YTfAyeaFhsCeV
	 3FWDvtnX9b44emrI1QR0TomvWHueNGHpV0M5tt0nP2jZnUShSz2tGO4HcFs5rQLQ3A/Cb
	 cvcKl2wjnarpiPkZ8QIiGokLDO1cmCJ+D/V5vMGF09GeIQKUZazC4iq3lNyO8jwp+G7PS
	 /0QYzQwBJu1XELJMXL2ssZXJfbio9MCFSIOic66hfne9jcIqjHGN08HWf78w2EaOzcBdT
	 wHfGVeyiziy1Dke/QwtPcTLRcmvADtk2AV/SbpPiumT5otTh7197kq8ICTHBCcKM2vw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SRwTO96e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791032586;
	bh=5vYWYhxU4xQfKWsjDQOb7SeHvjc62LEH9P0VQ0LIF0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nNB+DTKNtSoKcJ+JzK7FNbUpYPe7f2Vt726ekso+O6PJOjq5ho1a+EA6GdlRN1lL/
	 hzKhMX7BDxSXg/0YdpUh62aymAARnlSa/pXeS90/pReBI0V3G3kgWpmXejt9zcUpjz
	 IpVNMnwS5XPhnxgSlAnAw01OyVYJV9FrSDY7h4RU5/B3kKqjxcCGfrr5hbbjibYWnr
	 ySkdMSRSFFg2FXu85W/QarJGkM7Xka4S/CtGubH6Ghm8Nd/EbpqH2iYvym0LNP7i0J
	 WB/Bwk74BB2/IPfFqosUp7NwBpGNnMhzpBK9tPWDsEERug8b4jjWTfZBjgfI1O51PD
	 6m4F2N19muZSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6603F41350;
	Sat,  3 Oct 2026 13:03:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5A392E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9784941350
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:03:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXFNrvdX2Js8 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:03:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8DA7E4134B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032584;
 b=g1oJy72Uoju7DWC4hYlvBIyAp//Pd+QIWBO+PNewXhhldTqU0LF1xLqmSA5kUnGsymVk
 iwzVRQqBMfk/ZHpXboAmAMhKI9GSI9eemuWfZ1fLsMltaP9zxZzjZpcrd5kyvk2INaGEX
 UkERt6ajRCFsGXMaymiq83F9W10dqirXVg4LW5LRtGBsubDF7pJRbthsQFOkwJGTmIwKz
 Og45FfspRTv4J9IjKys/ZbrJ0I88ZmRuq3dAvHPmVSWb8YJeotjTLnFuhI9JMUOalS+xn
 3i2B7JIbeUymmBqhTbEXoWQ6UVaVT3C/+14O3DG7/tjaevMxEP7lLIOa0vW4K8uoGow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791032584;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=5vYWYhxU4xQfKWsjDQOb7SeHvjc62LEH9P0VQ0LIF0A=;
 b=nhM2hcLHdqI88DsYNkhw86s/pi+hyACPS860t4oIIIJsfb3WWpq5BcFT0KBP8QF3WFc6
 N2aYATHz1s0cT42h01XI+HMOyWjx55hUKgEWmNiwXNupQcAEjhtCOgA82D3ZsL5eKfsMV
 Iv752+Oe+kXXMv88GWhRCgH8XAPFpLlUk6DUeKJQ5cEiLI6z9i2wHJyf7KklEybjwdbYD
 Q19rZsrWGk0/YfjpJ1BsrFxJQvH5RHz1p1YHqV4rdJ4Z8Fm1T4icG9y8Q+y+WHTLkIugI
 TS86Z8NosFJUn3cK5p2tupqsieVC7DU06hjMrJEQFdbtB70TWv8JVp7q0qIsgCaydng==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=SRwTO96e; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=SRwTO96e
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DA7E4134B
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:03:02 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aa1d00daaaso513816a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791032580; cv=none;
 d=google.com; s=arc-20260327;
 b=smIq+gzA0KJ7IjbRMj4JrE6mX5NvxOiVtTcSuvO59SpaYQzDhdCNjEcgjFI8QRYg17
 NkmrwJiUXPQOJ1kW89g1mlqopsWSUy2s1u+jQCYypTYSeUEJSzIJLGziCRXt2NLRCbGn
 sx7sT+NuqXm0eGGjVl/m+ZK+JtwIRN4WewMbU88wy0LQ2UF9Ac9zRwL9wwANFDrOCDbx
 p8FLQwgnrTLbl2TWqCueJ6ynN6XU6+1trOBpEoFZOXvD1iJM7XgqxSgwPomr67ZDesiZ
 6bgo/i5qghb5lQs9qwoymlvdDqbK4Ds2JgY/X5Stpm20XOmC0o8cx0J+Gy/6f9BPQeQp
 fwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5vYWYhxU4xQfKWsjDQOb7SeHvjc62LEH9P0VQ0LIF0A=;
 fh=BEoPNN0ojtgxNz8fjZSoyMObtb+XDDU+qZjnWDTAHBk=;
 b=PLqtYPp2J3FaVvqskmCL+tMS3LRl1fxDjox0JwSxcE4oS9UvswuVbQ61pXzJMlcnn1
 R1eYQZMCNav8nx2ZxlvI/0HQERTj8fUihS3ku8vOlZdvNzKiy3uezb34TuitX/1zQcXd
 tKC/JIw5sS3FdOctDyDSfuHnUfqOh1VcnBUKb1NPFhzUGhMuCKeKwS/WvwzpAVATDQnO
 gs9obHhUbgf2gTkT7OoJ8geX1xgDZxsyUGXU/HFrQxAMj1ZyLxtMtXGyumAH3mb5u1Bk
 4y+6yrXcc7efqhbLBalkElYhtK8aCMCVmRQIiHJdimy/lg+MRPimKgCy0lsI6YNDF4Aa
 gUVA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791032580; x=1791637380;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5vYWYhxU4xQfKWsjDQOb7SeHvjc62LEH9P0VQ0LIF0A=;
 b=SRwTO96eYQTsXUeCC+nzT7BojBr8iDgFUxxpyyfMLjAZY6g/ZwI61uFai6F0PouKhi
 4qnRtk6UgeakpXAMir6T7/IJz3H7iQUl0vYKsQgmh1gmogDWbnDwTSBGVlyWGnIS0xPN
 vgK2C9BfI1AM4+2ejl5+qzosU89lYkHjc+cSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791032580; x=1791637380;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5vYWYhxU4xQfKWsjDQOb7SeHvjc62LEH9P0VQ0LIF0A=;
 b=dVD81eGr60unyDjCd9UcwVvvztTBcB08FcJqUbS12GKAernzWKo3Buk/01gGZdGbtd
 mJyx65TK1Z4QqE2GvDy4SOhujrhPfdoKRf2rPcOxq/J+eGfyCN3qMKMSNKWUDeam1vRT
 K5/Xabk/wD+2Syk/FFIjfr7TMdFBwIDLi/7lZl1sr0pJ7xfQxOuHtyhHNRTgKuy66MYj
 CQ6ThoVpYei1V0vLZW/WfeixvHFpOuHW8H/LBvGT5KDI2Agb4WW1dJcB4pRuvDa2EMmZ
 GSu4u7a0TXd3ubsBDDoKm8X+7/5cYJLum//KqlkFjMU6amnZSO4lVaLnpVMHxMbPE9Yp
 2Mdw==
X-Gm-Message-State: AFq9FYIMCZ+0Hg1NzeazvbP5f+hG1Bi4h7wS4GkEXaA1YHoZqez4ADlb
 3pdzbi0QTL0yeQ+WrwxFTwUF17C9I1cDm0p5oiLglwikuCM/gDMCKPywuJh9A9WYKI8Dndwpd+c
 5PXiCZp1ulCnCIzvHcIqg17v75TqGLQpfZcgrVoFQ
X-Gm-Gg: AYBFou1zeI67j1d5iwu0hgMn7Gah0QshVzLZ1LEmSX4LXQEWi+Wg7YP8D7l4QU6N56z
 vZpxQijzh6xFccVy1yGp2Z1E7CQ+yDTqJKxOpH1gOc6l73x/t/dg65/0oEs4mTGdqkVd7nKd6h+
 2TW4XzCKDbbyNg7NaQQ9z3kLca2WJOaG9QnOyFpemspFZ8qvUl/MpMcXnMfNFnKr7hzLk2skkRG
 Mx8A7X65g9A7bEXFWfLKM4bGp9jve4ppU1yADoQnLO3+j00AqjIttqb0JSv3E8so6jrPSo4eviY
 BVuF8daoJaztzAg9a/DqjWWhUoPtxpOgwdi7PlvoA/Re3lucusfqWtnQE/JNAo7Rpug=
X-Received: by 2002:a05:6402:360c:b0:6ab:373:54f9 with SMTP id
 4fb4d7f45d1cf-6af9e3775bfmr3972760a12.40.1791032579959; Sat, 03 Oct 2026
 06:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
 <20260918-ufs-spl-boot-wlu-v2-2-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-2-8a63e372bb6e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:02:43 +0100
X-Gm-Features: AclHuK8_YRjjVFF9W6cvDZWT91vrrOSd4TVygyYHHmrYamc7cZKSmTUvGciQvWk
Message-ID: <CAFLszTiLFvQjdt=0-R5tZqvnpkCyvqmOHyuc=vDQ06s181G9VQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] scsi: repeat an INQUIRY that a unit attention
 interrupted
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>, 
 Denis Mukhin <dmukhin@ford.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Alexey,

On 2026-09-18T06:35:41, Alexey Charkov <alchark@flipper.net> wrote:
> scsi: repeat an INQUIRY that a unit attention interrupted
>
> A unit reports the power-on unit attention to the first command it sees.
> For an ordinary logical unit that lands on the TEST UNIT READY, which is
> already retried, but a UFS boot well known unit reports it to the INQUIRY
> and so was written off as absent.

Not quite. My understanding of SPC is that INQUIRY (like REPORT LUNS
and REQUEST SENSE) is processed without reporting a pending unit
attention, which is why it normally lands on the TEST UNIT READY. So a
unit which answers INQUIRY with a unit attention is deviating from the
spec.

Linux handles the same thing in scsi_probe_lun() with a comment that
INQUIRY should not yield UNIT_ATTENTION but many buggy devices do so
anyway. Please can you reword this to say that it is a quirk, mention
which device(s) you see it on, and reference the Linux behaviour?

Since you are changing this, please use present tense ('is written off').

>
> Retry only for a unit attention, since a scan that walks a wide LUN range
> would otherwise pay three times over for every unit that is not there.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> drivers/scsi/scsi.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 49 insertions(+), 5 deletions(-)

> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> @@ -467,6 +467,38 @@ static void scsi_init_dev_desc_priv(struct blk_desc *dev_desc)
> +static bool scsi_unit_attention(struct scsi_cmd *pccb)
> +{
> +     u8 key;
> +
> +     if (pccb->sensedatalen < 3)
> +             return false;

After patch 1 only UFS fills in the sense data, so this is a nop for
every other controller. That seems fine, but please can you mention in
the function comment that the driver must provide sense data for the
retry to happen?

Please can you add a test for this? The sandbox emulator in
scsi_emul.c could report a unit attention to the first INQUIRY, with
sandbox_scsi passing the sense data back, so that test/dm/scsi.c
covers the retry path.

> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> @@ -490,11 +522,19 @@ static int scsi_detect_dev(struct udevice *dev, int target, int lun,
> +     /*
> +      * A unit reports the power-on unit attention to the first command it
> +      * sees, so give it a couple of chances to get that out of the way.
> +      */
> +     for (count = 0; count < 3; count++) {

As with the commit message, please can you reword this to say that
some units (wrongly) report the unit attention to an INQUIRY?

BTW I think Linux only retries here for ASC 0x28 and 0x29
(not-ready-to-ready and power-on/reset), whereas this retries on any
unit attention. With a limit of three tries I suspect that is fine,
but it might be worth matching Linux. What do you think?

Regards,
Simon
