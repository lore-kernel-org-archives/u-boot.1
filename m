Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAFACAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80213832F9;
	Tue, 23 Sep 2025 04:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LyM1d3Q1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6FA83390; Tue, 23 Sep 2025 04:14:26 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A267383211
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-3696f1d5102so20086131fa.3
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 19:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758593664; x=1759198464; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zb7BocCxOkot4RX6KFtvjmNCN68T4t8qIWccQvzBEbA=;
 b=LyM1d3Q1E17psJ9eK1Mps5tfnnY0oG788RsVV+ETxJrKmDB8NRG92iIikTvWJaWq8z
 EAE1xwHZifEty0vzLh3gtp7O1nbh52sOnf+vt1FMSiDmZFc0tNlTkB+be9uoj6c0GY4I
 mAH1ti1r6TmVzOtEtC/7Hk9XQYLTa1Yt9ldDz/G0CpWq/vSwfftQlAkkZOhYvtBxO9DL
 bAnbmGnDu3VaH7uR330esSbnTheMm+9fKWWnay/CS7Fy/OJZyD6dXTUatd/0w8HSnzej
 QYbvPgZT4oXQq6WRUpXmNAjJGlTfR4tMxBgGsSZlMwKmwZ3KY09h8jzsj2ZZmvNt4Ge8
 sv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758593664; x=1759198464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zb7BocCxOkot4RX6KFtvjmNCN68T4t8qIWccQvzBEbA=;
 b=K0O/YaWTS/4RgEKhSKmMQbwBUX9Eyfe4urXZb+zYMX7hClWDdXz73dy+p0GJslkfR9
 DIL4H00WFGN4IzvJlPdGJDY5iPAcXmv9lv24iUtrvNusZxGGd6FZ7uX0qYKX8Mw4ZJX3
 XTTYktjcvfeguPdLLGEH5VrMBL1w776iMP4GgwmAjQBAR4YRL7+BjIQYOfHifqbZpMMS
 mjWbQ5SWDhBFzD6yo0GAXHlthr/Xq/fhTHnzNRpiD7zJW8eZZz6HuknaAEfTMBzQplDP
 8roGQEqUjl9XM+GLf0eYVmiSgYhjlT+7wPTHI2p/ZgXmAQb6vr7pQlxey8pIAvTlSdVb
 dZZQ==
X-Gm-Message-State: AOJu0Yyi8U4YsVj0yFwWjhNU8dtQjwbCON0iU2zEAL8Ok2aH98m+/6N0
 bZ7C3cMMMZ7o+Ai7RYxMUM8EmU0OdO1MC9vGlbz5gQ3EV/3Qql9gs6JRTPcHMTtrcBlqbNLpnxq
 sZK/yScJbqVHwQLUPMCr0U/HqCSfHQHY=
X-Gm-Gg: ASbGncuSLXgrjKGn4es4RzjkEAK0o5/OhEpp6YrIAS3gahKlvJqdSl369nV38euvNO1
 8uKflLqcOV+Dck0HZBcMV8zUVoUCX8xeslnVKyzsVQuDHYVNNAR0woDiu0/6jtiA0fhcGx21vBi
 H4rdCPxMEoMRntW8aJfZ56c4sC/gWd59r1CSJaqfvhtLKImrfK9mYslWJ+L2l30g2GtJORXkbIh
 jtD+GsEx+gFblx3KTmvfL7mG1HBrYhS0qx/z8A=
X-Google-Smtp-Source: AGHT+IFc/7kIAMAlh3kWTBr8yJrac0SwmYOS7Q85E0RQEXC2mjhl0QTV8Kr10HzIeLca7hWXVEAXru0wIfRWRIA6Hf8=
X-Received: by 2002:a2e:a54b:0:b0:36c:c37e:3fd5 with SMTP id
 38308e7fff4ca-36d1519ec28mr2507101fa.11.1758593663776; Mon, 22 Sep 2025
 19:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250922111143.1204915-1-ye.li@nxp.com>
 <20250922111143.1204915-3-ye.li@nxp.com>
In-Reply-To: <20250922111143.1204915-3-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 23:14:12 -0300
X-Gm-Features: AS18NWD9sDajXZr5o2QGUjRUpG9dZyskwBqYP2gqagoVhCC6jA6ehFCBum-oS4M
Message-ID: <CAOMZO5CcvBz97mOpZ0RwAxGMJg9ry6QEnNMZCTMUpLufMnQYSA@mail.gmail.com>
Subject: Re: [PATCH 3/4] spi: nxp_fspi: Support i.MX8DXL flexspi
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, peng.fan@nxp.com, 
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 22, 2025 at 8:12=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> Due to a errata on i.MX8DXL flexspi, we can't use AHB read, only can

Is this erratum public? If so, please add a reference to it.
