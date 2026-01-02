Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C084EFA3726
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 10:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E47418420D;
	Fri,  2 Jan 2026 11:18:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="E9usyZNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D024A84209; Fri,  2 Jan 2026 11:18:45 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62E6184207
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 11:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 093F73F520
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 10:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767349123;
 bh=MKnvsVMvqwLpISeGEsEIErTqioV9zEU3GawxEYkpuxU=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=E9usyZNKPRF+LrycDhO5MjeWOo3oAW8R+uQTIIBcj/NbOB9N6OdI6w8YHRbTb8MMD
 Bck/N0Lu4nzjlmXDerauNP2GppbMg3ifzcUgvWuzA+qS13boefDlgxDZlJC1faTI8y
 4P4DTqHOJEyQLeG4PWJ6eM/6r9xz7Fv6Im5i6T8IPAx+maDKyeH5+pcZhFsWB7P50z
 MX01Bl9AW/8Hy8Y55MARHGrj6mIfodEa/T5u1avJqGVuv0M/hl+46nu8RbMn02+bdD
 WFQdO5mXoA3/tNtr3KIS3kkdmdP8Ug1RKThWjZg+xtOlxcuIr3M5wyccbLDFD4o8gl
 wcTN6Edp1EtO5zEZBIdqtmtNVCdrk9QX/jQPUjVbPG4aL2cWnmFejNdSXDr1gR6hlk
 sLtNhbK6+pHnu4qSMh8l0+5UcXuZY2GIlQIDkZAhkQiDyL17MYmoJqLtjf8p8W9YVG
 z/JE3n1uR1FVEaX92M4F3d6IILM/+Gy/4kytCBZIsc+ujFbgDQK3lby+2f8kyiGMYu
 VTr5MbDClsE7cooTkrfzFLp74SIZzfUdR7NpQBkZ8PG9G06/RyXLD7u7MBec+sfGVo
 4/g6X20iPKTkUjAn2I56/nOOaH6iQPZZMeroaJTsIcf0b/5GgHRUkAql6IJLAWm2A/
 RMK1HIulHsJ7bbqMXnxNa4Kc=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-431054c09e3so7490027f8f.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 02:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767349122; x=1767953922;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MKnvsVMvqwLpISeGEsEIErTqioV9zEU3GawxEYkpuxU=;
 b=pYhiIjt/6TWbkqR/IrSgDXDFG0WRmIX0TQ6Lm0uAJuDUe8kNKjybSyZyry+hEdKBiS
 ZehY834DrKT3r2k1eup3U+4hEG2iAYiaNZewpQ2RE9+U5xgE89gvdzYM/t6zhfP7MOuj
 oK/DmxrDZi0ACDKtAv5LXSJ205setLLbjGIKXq1mTkzwYOzKzAe73Se7I6a3ujZwMQC6
 7jE/fl964sUZBhxhlRsMuRG1aLBkf6CkUES703quEIiPbXGYOMbT31kT/gcBpBfULP06
 l+nhrCChi3IQFnt1oh/hCb9e+RqwCyB5gLGWawXMFNYvWLQkcWFAOx6g5hW+fXLaxjGM
 74WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEURIthQIHMNYLfG/7NlIsAC4amwd5J30U4hxUa0qCCOnZjhbuexxywlioauxBRA6rp3qCHoI=@lists.denx.de
X-Gm-Message-State: AOJu0YwVPqJpBQYbvtF25eI9XNi6Kn8tqNoIJr1IzR98WSDxhHur6dTS
 ajQ6zvk6LP7oGw7rK0OPf9ddYWgAXZ5ZTZIRFd1H8wwp9c05IXmtGnAXIH7PVfo9/2U4bXCCIQy
 PjnQ5MVxMamMJ4pqiPnzmuFN32DxVcyW3IvLDFpJlKZpIEzZaNHv0Ymo9AdffL5rdH+QUoVY=
X-Gm-Gg: AY/fxX5XcCAbBC2nnzQmg+2KFmykqeS4cM7hD8EoHhMaMywqdBYmOG3nL38/7sWN4xs
 V9h316Xo6iyd1730uqbdSJAx6WEskmA7B44tVVwNyuUyHqFPZqaJCm66kLYIZVww0HSnFNp6MXn
 wJJ4U+yb/nI/9oVtIEzgv8PCaTEdK36cikO0Ax1Z+NX/fiMlt7HL0CWRByeaGRVVv2K9keXT6Si
 9GGxHZzZXSt48XPEcV1jAr6ThARnxg3zmuCXluQyblxacRKGrl7/7WQT7s8rtW7HZPvmKPVjdgJ
 H9uNyQTHcJTVbsdW/W0bvP/aEnytklt4ET3FjShHP6kGO60s+eJGs8zAAY943VubTAiyWhbFfn5
 vU4QTIqcjy7GLB1YSDzS48P8w81AGSOqKtbq1+X0DIXxwXOF5dDTKFy/jzPjnPq+z0w==
X-Received: by 2002:a05:6000:609:b0:431:342:ad41 with SMTP id
 ffacd0b85a97d-4324e6fa1a7mr54825470f8f.61.1767349122550; 
 Fri, 02 Jan 2026 02:18:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjM2ly/Xs45zo1sXWGBY5favU8jrGXY4LYp9PBhIlbGL1QzKLQ6b4b0SSIrDEuo3ZTpxOnIw==
X-Received: by 2002:a05:6000:609:b0:431:342:ad41 with SMTP id
 ffacd0b85a97d-4324e6fa1a7mr54825444f8f.61.1767349122079; 
 Fri, 02 Jan 2026 02:18:42 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab33f5sm83847380f8f.41.2026.01.02.02.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 02:18:41 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <dc274156-e598-4c14-82d6-54ae6746c659@gmx.de>
Date: Fri, 2 Jan 2026 11:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH u-boot] docs: kdoc: handle the obsolescensce of
 docutils.ErrorString()
To: j.ne@posteo.net
Cc: Tom Rini <trini@konsulko.com>, Jonathan Corbet <corbet@lwn.net>,
 Zhixu Liu <zhixu.liu@gmail.com>, u-boot@lists.denx.de
References: <20260101-docutils-v1-1-81391910aca3@posteo.net>
Content-Language: en-US
In-Reply-To: <20260101-docutils-v1-1-81391910aca3@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/1/26 15:31, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> The ErrorString() and SafeString() docutils functions were helpers meant to
> ease the handling of encodings during the Python 3 transition.  There is no
> real need for them after Python 3.6, and docutils 0.22 removes them,
> breaking the docs build
> 
> Handle this by just injecting our own one-liner version of ErrorString(),
> and removing the sole SafeString() call entirely.
> 
> Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> Upstream: https://git.kernel.org/linus/00d95fcc4dee66dfb6980de6f2973b32f973a1eb
> [j.ne: Adapted from Linux to U-Boot]
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>

path = nodes.reprunicode(path)
in doc/sphinx/kernel_include.py is also not supported anymore.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   doc/sphinx/kernel_abi.py          | 4 +++-
>   doc/sphinx/kernel_feat.py         | 4 +++-
>   doc/sphinx/kernel_include.py      | 6 ++++--
>   doc/sphinx/maintainers_include.py | 4 +++-
>   4 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/sphinx/kernel_abi.py b/doc/sphinx/kernel_abi.py
> index 32c50e496b5..930e9273b16 100644
> --- a/doc/sphinx/kernel_abi.py
> +++ b/doc/sphinx/kernel_abi.py
> @@ -44,7 +44,9 @@ from os import path
>   from docutils import nodes, statemachine
>   from docutils.statemachine import ViewList
>   from docutils.parsers.rst import directives, Directive
> -from docutils.utils.error_reporting import ErrorString
> +
> +def ErrorString(exc):  # Shamelessly stolen from docutils
> +    return f'{exc.__class__.__name}: {exc}'
>   
>   #
>   # AutodocReporter is only good up to Sphinx 1.7
> diff --git a/doc/sphinx/kernel_feat.py b/doc/sphinx/kernel_feat.py
> index 2fee04f1ded..cca48f6f1a4 100644
> --- a/doc/sphinx/kernel_feat.py
> +++ b/doc/sphinx/kernel_feat.py
> @@ -41,7 +41,9 @@ from os import path
>   from docutils import nodes, statemachine
>   from docutils.statemachine import ViewList
>   from docutils.parsers.rst import directives, Directive
> -from docutils.utils.error_reporting import ErrorString
> +
> +def ErrorString(exc):  # Shamelessly stolen from docutils
> +    return f'{exc.__class__.__name}: {exc}'
>   
>   #
>   # AutodocReporter is only good up to Sphinx 1.7
> diff --git a/doc/sphinx/kernel_include.py b/doc/sphinx/kernel_include.py
> index f523aa68a36..6522de9dd69 100755
> --- a/doc/sphinx/kernel_include.py
> +++ b/doc/sphinx/kernel_include.py
> @@ -34,11 +34,13 @@ u"""
>   import os.path
>   
>   from docutils import io, nodes, statemachine
> -from docutils.utils.error_reporting import SafeString, ErrorString
>   from docutils.parsers.rst import directives
>   from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
>   from docutils.parsers.rst.directives.misc import Include
>   
> +def ErrorString(exc):  # Shamelessly stolen from docutils
> +    return f'{exc.__class__.__name}: {exc}'
> +
>   __version__  = '1.0'
>   
>   # ==============================================================================
> @@ -109,7 +111,7 @@ class KernelInclude(Include):
>               raise self.severe('Problems with "%s" directive path:\n'
>                                 'Cannot encode input file path "%s" '
>                                 '(wrong locale?).' %
> -                              (self.name, SafeString(path)))
> +                              (self.name, path))
>           except IOError as error:
>               raise self.severe('Problems with "%s" directive path:\n%s.' %
>                         (self.name, ErrorString(error)))
> diff --git a/doc/sphinx/maintainers_include.py b/doc/sphinx/maintainers_include.py
> index 13557d3d3c2..ab79a74dc0c 100755
> --- a/doc/sphinx/maintainers_include.py
> +++ b/doc/sphinx/maintainers_include.py
> @@ -22,10 +22,12 @@ import re
>   import os.path
>   
>   from docutils import statemachine
> -from docutils.utils.error_reporting import ErrorString
>   from docutils.parsers.rst import Directive
>   from docutils.parsers.rst.directives.misc import Include
>   
> +def ErrorString(exc):  # Shamelessly stolen from docutils
> +    return f'{exc.__class__.__name}: {exc}'
> +
>   __version__  = '1.0'
>   
>   def setup(app):
> 
> ---
> base-commit: bb28daf51301546fc2b6882e51f39f5d12952375
> change-id: 20260101-docutils-5899af0ac74b
> 
> Best regards,

