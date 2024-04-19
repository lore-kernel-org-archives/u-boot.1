Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E47C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 07:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C79B886B7;
	Fri, 19 Apr 2024 09:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Vhm/N6Hd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04379886B9; Fri, 19 Apr 2024 09:31:51 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0862F886AA
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713511907; x=1714116707; i=xypron.glpk@gmx.de;
 bh=FMZPwPbe+k893pfq6sbrqL7uRqcLgR79G12KhLN0M64=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Vhm/N6Hd5VYC7RHQxGt5xI+689YdmxMAZAHNOaghkiWmOY6gBOs08550YpwBXYxJ
 2iV6bPlSwgYEFmcy48XN5fgBr0/jaESUf4qYOuZntcBK2F9gYsTUgljwmqM2Q0V6l
 uoFB5hHqLGmk9LOrav8JFDOd2PC4romXdL+cH7Imk4sJn3BP6gJBxWBV1uOKxN/iJ
 X2erQkDbYIoyazI/tusFJhs92XX/0GuTcc5XXKAuLcm8IQYX4+LO/foYOXRMGbkXt
 gGMy5lrTlWn1lxUVBJt/2LTbkeFS5tPcqDedJ2Cvo/STA11m7vn1VN1ru8IoRdbpc
 u/RHoac/lWe5lIHJkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq6M-1squi31m4O-00tElI; Fri, 19
 Apr 2024 09:31:47 +0200
Message-ID: <7361ddbc-6ef5-47cf-9369-53b72ec5bab7@gmx.de>
Date: Fri, 19 Apr 2024 09:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] doc: Document capsule generation through a config
 file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240419065542.1160527-1-sughosh.ganu@linaro.org>
 <20240419065542.1160527-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240419065542.1160527-3-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OScox05oUFtX6JwdH6DdqIxXRDnXol+MpG32nBE7LghyJH/yZgu
 tiLug9TxdTm1gAUJoADEM9UbhgHKUQz3VPFNvlDn/xFGc+Qii7Yig2+Zn+OkggbPQGfCFw6
 2D5T21ddR3JOOFcl/UiTT03r16sl/ypvtCRawGZTx1X2PJWIPMvCDS54s0aO1AMC+4ajPB5
 vmD0y/VryMAPXE30g31iQ==
UI-OutboundReport: notjunk:1;M01:P0:3XZnFGL6yuo=;l8/eZzLdW+H9xm5BDTlDYTcaaQ+
 lRvhMrONvnczvWBGVDy3Hzwe3hvRN+T6xwx5RaljELVQ7/jwGrMrj6so8VO78mOMJnjakKd1B
 QeY7GGH+0CRDTdO/iaLoZIX0t8FDBtUTD0GYyyMjNx2x+Vkq/bvu7g6ZZxFuMm280ZGADPqKU
 jOxSCY37HI+Mgd5gro0OYhdrqNZReilI9vSX8A7kMnep7a9HyI7fsG8taFONRsfS+HPAEiqZw
 pUIZWY/l2CVc6jV/s1R3OCAm0cn3BacR/eLXinVpCun8Yzx3CUssq9GRvSC7A6BOpC6x6k7tB
 4+RLlbR76r0KgiIk5LhSWREjCAWF0UoqbNfg0f1oIje9ijqPyWZdxcVrqBoWno34NYlCblvxR
 dZ7Ntu8v9vn1sa5U5EeZwrM63lDkoHztFPD2Zk6f+drnPOSdDHTxc02GhHGGwufe84BmsW+Nw
 0XUymV3+Z3zsDjhLo048zqcC/d12PC1HBUcEnZbW0U1JVyfL0fH7jXhSYBjnA/ajesrgvFqD2
 h6829pJw4zUZc7mIwaBx7Jy83lBmUsBfHUEzUr/Ra0QHyBMlJQmkTefv+tfURpbdBMbOgrvqe
 JTQd5MGDADWw6MdTf3Nojx8LTVvy98BOJ5psjeNRPuoh+A+V1KRvxKLjyyIKdKRLphTXH4i1C
 e0G7oZarvrV4yk+HBZFS6SyG2ULrkXzjUgGyDtfNB+jQ8/CgtV8fI9oPZ1i7znNITQCWJmd1Y
 GGRMGs+IBwlpfu4kHiEOOG5CRclZJxVj+irCwMSTM9HnscamwzBGuevU1XAg+bUVS0De8odj/
 AKiU6UVwTtBRhOk6LS74S2DxludWwf7ujulCqxE1x24uY=
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

On 19.04.24 08:55, Sughosh Ganu wrote:
> The UEFI capsule can now be generated by specifying the capsule
> parameters through a config file. Highlight these changes in the
> documentation.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   doc/develop/uefi/uefi.rst | 70 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 0389b269c0..8586127a83 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -318,6 +318,76 @@ Run the following command
>         --guid <image GUID> \
>         <capsule_file_name>

The users deserve a man-page mkeficapsule.1 that can be installed by
distros as /usr/share/doc/man/man1/mkeficapsule.1.

Do not expect the user to look up the information online.

>
> +Alternatively, the capsules can be generated through a config
> +file. When generating the capsules through a config file, the Kconfig
> +symbol CONFIG_EFI_CAPSULE_CFG_FILE is to be used for specifying the
> +path to the config file.

Why do we need CONFIG_EFI_CAPSULE_CFG_FILE? You could use a fixed path
or an environment parameter.

> +
> +The config file describes the parameters that are used for generating
> +one or more capsules. The parameters for a given capsule file are
> +specified within curly braces, in the form of "key:value" pairs. All
> +the parameters that are currently supported by the mkeficapsule tool
> +can be specified through the config file.
> +
> +The following are some example payload parameters specified through
> +the config file.
> +
> +.. code-block:: none
> +
> +	{
> +	    image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
> +	    hardware-instance: 0
> +	    monotonic-count: 1
> +	    payload: u-boot.bin
> +	    image-index: 1
> +	    fw-version: 2
> +	    private-key: /path/to/priv/key
> +	    pub-key-cert: /path/to/pub/key
> +	    capsule: u-boot.capsule
> +	}
> +	{
> +	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
> +	    hardware-instance: 0
> +	    payload: u-boot.itb
> +	    image-index: 2
> +	    fw-version: 7
> +	    oemflags: 0x8000
> +	    capsule: fit.capsule
> +	}
> +	{
> +	    capsule-type: accept
> +	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
> +	    capsule: accept.capsule
> +	}
> +	{
> +	    capsule-type: revert
> +	    capsule: revert.capsule
> +	}

Is this one file? Are these multiple files? If these are multiple files,
please, put them in different code blocks.

What are the curly braces good for? Please, use an established file
format like YAML or JSON.

> +
> +The following are the keys that specify the capsule parameters
> +
> +..code-block:: none
> +
> +    image-guid: Image GUID

Please use the following formatting:

image-guid
     Image GUID

fw-version
     Image version

> +    image-index: Image index value
> +    fw-version: Image version
> +    private-key: Path to the private key file used for capsule signing
> +    pub-key-cert: Path to the public key crt file used for capsule sign=
ing
> +    payload: Path to the capsule payload file
> +    capsule: Path to the output capsule file that is generated
> +    hardware-instance: Hardware Instance value

Please, explain what a hardware instance is.

> +    monotonic-count: Monotonic count value

Please, explain what it is used for.

> +    capsule-type: Specifies capsule type. normal(default), accept or re=
vert

ditto

> +    oemflags: 16bit Oemflags value to be used(populated in capsule head=
er)

ditto

> +
> +When generating capsules through a config file, the command would look
> +like
> +
> +.. code-block:: console
> +
> +    $ mkeficapsule --cfg-file </path/to/the/config/file>

All available command line parameters of mkeficapsule should be
described in one place.

Best regards

Heinrich

> +
> +
>   Capsule with firmware version
>   *****************************
>

