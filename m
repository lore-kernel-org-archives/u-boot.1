Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACC1E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC18801DA;
	Fri, 13 Dec 2024 13:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PpUhwuMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51CF6801F5; Fri, 13 Dec 2024 13:18:02 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10FA380137
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6ef81222aaaso17061887b3.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734092279; x=1734697079; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ejw/vTR7+EbqlbI36njLXK9DnEf8MZtlfIif4PaDSqY=;
 b=PpUhwuMBbSeIQc13bh3aNLvT2l9vYQ/sUd5VcOKvvnoSjQzKb79u0QUegRt9DsFChR
 j/7AQrluGT6medgKpCnQxmlvy/nlTkizJpPJcOgkrNi0tuYkhxQpDaXdZtosDAfc1t00
 rVtby1v14FfNirayNNWCU8UO3qpIYvXc1Ui6cRCMks1SAQdNjZpAf2O5vI8Y/GK5CCg3
 H577t+91/noE+iOuQGkOLSGbJbiJmqpriKuBNoWhNnHGUwKLuYjOIkopEVBxW7PQzp/b
 IqiI1sHNU9PgS8kHKRP7b6GJpSLTJv8XRF8JcUMejEMO5uHJwWjWR6RxHQRFu8GZiEJ8
 UM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734092279; x=1734697079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ejw/vTR7+EbqlbI36njLXK9DnEf8MZtlfIif4PaDSqY=;
 b=kQ6161HM/S43iR5NkLa+EaUlYVhrfDzP5M7EJ5GKR1zLyCwxmUstY/l3HieuEUqPbQ
 kK14guZajJD5irZd6oSXMjU4yG4FQ3Miwrk452xiPYXwU13VFc2NX9dXSR8SR2LNutBa
 ay17XWxGjqqKsFL/IgxJB0TQDheGcG0zy/DxrH/UsVoWJI1t0GaW3IIW9qJ+pVPqV6R2
 hl84LiQ+mxFMbkoaoeTjpxEedhaQYUkWve1ixcD7Cgcw4FDO32QpFmoi/NNscqbl0d8E
 TCEX6mDIG3LQmFpixWJVuHjKpEfpQwVmha8tpaUYkiabg4zkZ+l5lG7QBlG4GQv9OZ+5
 L+3w==
X-Gm-Message-State: AOJu0YzwlsfcEaGGGRAj6dShL4wD2j5ap71tERHPK/agVJwajnsrBglQ
 bCGyxZ5+T0QvLoR+1D1/Apab/ss0D6R8GECV+/qEK+CLvLJQv8AbAiMIFXkrfk0H5WQ6nVvnkCa
 qKxFbUf2zJpJqvB7wUD5JOiKEwMkR63wa7jTSAQ==
X-Gm-Gg: ASbGncvV9grvTZsmOfAMjukgz8eLCC98qPhgUDnnXXfITCj/CajREIE9Sc44NAXLiwa
 1ErqNtMkfvDwvBj6rDgrmTxkgdZrrDWTFbhuLnQ==
X-Google-Smtp-Source: AGHT+IFY/u/G+KAjVtuQRoyKjZ2t5tbZTp/P62GBa9jpJXLLWCJsDPWrHLpdRaqPQ85mgSnSrp18reRmMdfxArQTgBA=
X-Received: by 2002:a05:690c:64c6:b0:6ef:aae1:ac6f with SMTP id
 00721157ae682-6f279ae3757mr22793977b3.3.1734092278939; Fri, 13 Dec 2024
 04:17:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1733757864.git.jerome.forissier@linaro.org>
 <a23d88947ef928e3492445796855db2c00d64b2d.1733757864.git.jerome.forissier@linaro.org>
In-Reply-To: <a23d88947ef928e3492445796855db2c00d64b2d.1733757864.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Dec 2024 14:17:23 +0200
Message-ID: <CAC_iWjLBRSpen8V77nrnN9J-NN--EpAV5-V-PHqbsvsVuAM=aQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: test_trace.py: test "trace clear" command
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>
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

On Mon, 9 Dec 2024 at 17:32, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Also test the newly added command 'trace clear'.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/py/tests/test_trace.py | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
> index ec1e624722c..29c115275da 100644
> --- a/test/py/tests/test_trace.py
> +++ b/test/py/tests/test_trace.py
> @@ -70,6 +70,32 @@ def collect_trace(cons):
>      return fname, int(dm_f_time[0])
>
>
> +def clear_and_collect_trace(cons):
> +    """Pause and clear traces, return the number of calls (should be zero)
> +
> +    Args:
> +        cons (ConsoleBase): U-Boot console
> +
> +    Returns:
> +        int: the number of traced function calls reported by 'trace stats'
> +    """
> +    cons.run_command('trace pause')
> +    cons.run_command('trace clear')
> +    out = cons.run_command('trace stats')
> +
> +    # The output is something like this:
> +    # 117,221 function sites
> +    #       0 function calls
> +    #       0 untracked function calls
> +    #       0 traced function calls
> +
> +    # Get a dict of values from the output
> +    lines = [line.split(maxsplit=1) for line in out.splitlines() if line]
> +    vals = {key: val.replace(',', '') for val, key in lines}
> +
> +    return int(vals['traced function calls'])
> +
> +
>  def check_function(cons, fname, proftool, map_fname, trace_dat):
>      """Check that the 'function' output works
>
> @@ -304,3 +330,7 @@ def test_trace(u_boot_console):
>      # This allows for CI being slow to run
>      diff = abs(fg_time - dm_f_time)
>      assert diff / dm_f_time < 0.3
> +
> +    # Check that the trace buffer can be cleared
> +    numcalls = clear_and_collect_trace(cons)
> +    assert numcalls == 0
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
