Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715ACEA71B4
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 01:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08DF680433;
	Mon, 20 Apr 2026 03:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UGFBjEPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12DEF80433; Mon, 20 Apr 2026 03:18:37 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D592B80087
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 03:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82f4a53ae20so1887636b3a.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 18:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776647913; cv=none;
 d=google.com; s=arc-20240605;
 b=GOxPWfgBcgq7rr+x4QtUXIlK2GDgM1o7KYCAjp2Z0anWBRkX9cOjlcrLlzeOGxJSJX
 FxwAhuAF6hWut+Z8u9qQnLHGjx8GA1BBSnbOO6ca9OY4MGKUi9mv5vQ5jvl/G4zF8URJ
 dToyq1VAVhu4bsQYx2iSNgMhi9EF69PaGbqAL2i3z+zeQbR1gtbBCklgMjhApkjH/Zym
 RWqacBl8892UF+zHdxJdQzwHsvN8LC+IpOrPrNuxQTc6jX/dW99odKpkUIylMBNebKWl
 hmu+A8JcWO+6F3TgvpCmQiHlpuYD7w3h+Zftx58AjSmKV9sMBTUDQ4nPjGeiCc1EE9ve
 FoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TdRDuPNZhQLd9WBITx+MdRktaZTgJPHvKKuzARZYYjU=;
 fh=S8xjaNhDK5zkqclbPZi4D14oajyF+NpuR2kRzRAZ3EE=;
 b=MoB5LquYzUt7D/3MRwAmzHnkBDV6VdAfx9pO48NJcztjjhg50Mvn4I4KqGbdN4lMRI
 HPaNPQUL0fcmH0Cj2t0E5bL6T7oTg/QqhfW64L2U1gROzQYQejk/NyXLdRlNMd3bnfGK
 b3r3xSK2M6OXXO5pNiKEcckENo9fJG8Nkdg8X22CUE751dFOxnmTpooNnhHdF9Ca3m5s
 cgVuAEvWCHJSnzopWcWmVoElsjaMMU67xMKqklkxUxiOfwPq/HKbM11RKEmc6OSABYLY
 Hi0xibGxg5B0QKLOXEuk9enjExnlzraq0ieRXDYHKiH/dPLdD8h66kDqBj+EmiG9qdpZ
 aDxg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776647913; x=1777252713; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TdRDuPNZhQLd9WBITx+MdRktaZTgJPHvKKuzARZYYjU=;
 b=UGFBjEPA+cqWlAZFzfwCKWhtKpldyU4jPUKtE5rKpZTgkq0EPvGHR5VzYTGq85VY85
 gZn8qe4md6/JLm9gTHoZb0ZINsAH0FcWKLfWOlnNon4CadHmBau4kKZFa9DKNlGls4CR
 exytrIN+kKz38qFP/wllywNeUuzX/TsYM2zaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776647913; x=1777252713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdRDuPNZhQLd9WBITx+MdRktaZTgJPHvKKuzARZYYjU=;
 b=rVoywezRABtx0wWB3+46eygk9ol1dSBfyJhejuuPB2dwQlirL/INAOQ1wBjF1/HE4z
 EOEqwOlk+kGEstOQn1FgER5dn/iw1YF3Z3N6kVgVMLrBCDcQy1i0Y2FrbkGCJMzv9W8H
 YsiBdhA+RWVdRrZS74+MF5vgirQH5PcBbNJDIh+YfypdoDQuRuLXTRhVEAgIn265Tq4S
 7rXeEqolDQl+1qeme6hGvkHcYipAs9Tpxfzllw8KdNs4bG6YuQMacE03wKHpqryIUASM
 Tra04CGwS/RB+nOB+DYOlW1XO7FBPQ4PDJRObKo8Aw3VkpYlRJd6h713FUpxXHE5qFgb
 TtOA==
X-Gm-Message-State: AOJu0YzVg/mY4ZBrDKjQxQ01lAn72Hb9thA4Gu/mc2XOLNt1LSWpop9U
 BF0x3XRlOfoptM8cjaE+uJXPbYyUE3YnLndujTSZH4davlfJ7Otc9zr2wG/J1SDMcjVqbFXmOyY
 QtigmS0dLLSCPhF61UqM5eDBAQcCFYDpt5qViOQpR
X-Gm-Gg: AeBDieufNt11xuNoI2YSyDJtJ+of+SO9yDkqRyNDvfU7R7/bSx2+DqSR9M+eRcgDH4a
 fTVUuO++1E7GaXubU0AaGol03YZ/RF/b+3pzQIEaKk6HajWLx5nC0GOO/QUbnyH8dRzZI1neAuE
 bTJ4jV5lBwZmz/8ONUm1Vm8ykcZQz7PpWMf9oWJZfWcMwghvQTs9S4Xg8DA/4iNIcxV9lRQQC8a
 ELpS6Oq+HDPsbtOvToQ5Zt+X0W7KrOmZnwTM6E9sF64xTpSWb5fz3pF+GvQq+h3HodV38FVYX4B
 0VG++o4y803whq+4SGtj
X-Received: by 2002:a05:6a00:2ea8:b0:82d:603f:f3a with SMTP id
 d2e1a72fcca58-82f8c8c7bcfmr11624971b3a.24.1776647913317; Sun, 19 Apr 2026
 18:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
 <20260419-type-v3-5-ec49acd6870e@oss.qualcomm.com>
In-Reply-To: <20260419-type-v3-5-ec49acd6870e@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 13:18:16 +1200
X-Gm-Features: AQROBzCVyEUNC6cb_0hAqao65PDAT6kKBtXTil08UgkfZ5i4sTkUjJD9vyJmjeg
Message-ID: <CAFLszThEYuqt1D_p=2O-nmY5xEgNCxQpftAyffWFp2uhnrBDkg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] test: dm: Add partition type GUID lookup test
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michael Walle <mwalle@kernel.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>
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

Hi Balaji,

On 2026-04-19T10:24:02, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> test: dm: Add partition type GUID lookup test
>
> Add a unit test for the partition type GUID lookup functionality. The
> test verifies that partitions can be correctly identified by their type
> GUID, specifically testing the ChromeOS kernel partition lookup.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> test/dm/part.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

> diff --git a/test/dm/part.c b/test/dm/part.c
> @@ -195,3 +199,47 @@ static int dm_test_part_get_info_by_type(struct unit_test_state *uts)
> +     if (!IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
> +             return -EOPNOTSUPP;

Please can you return -EAGAIN instead? The test framework uses -EAGAIN
to indicate a test should be skipped (see test-main.c lines 486 and
492). Returning -EOPNOTSUPP will cause the test to fail rather than
skip when the config is not enabled.

> diff --git a/test/dm/part.c b/test/dm/part.c
> @@ -195,3 +199,47 @@ static int dm_test_part_get_info_by_type(struct unit_test_state *uts)
> +     partnum = part_get_info_by_type_guid(desc,
> +                                          "FE3A2A5D-4F32-41A7-B725-ACCC3285A309",
> +                                          &info);
> +     ut_assert(partnum > 0);

How about ut_asserteq(2, partnum) here, since the first ChromeOS
kernel partition (KERN_A) is at partition 2 in the test image. This
makes the test more precise and would catch regressions if the search
order changes. Alternatively, you could verify the partition name
using:

ut_asserteq_str("KERN_A", info.name)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
