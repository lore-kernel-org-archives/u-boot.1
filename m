Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE41DC88E63
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 16:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 750BC60601;
	Sun, 13 Sep 2026 16:15:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfgCHc2ft9za; Sun, 13 Sep 2026 16:15:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BC0DA605FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789316148;
	b=oUttKeErdhIZysBobp77N7OVYeFSdtnM0Y+A6Wfl2s3UP2g9UrhdtLdP/jtXiQYD3sLP
	 vxEpEelXiaI1XzcPO0ZOBv2h2CYfdEhoUuS+FtsWZymxi2IDcSMtciQof7zh9G6MlugB2
	 QbwwQ34hTGHNh2xjEWoIOjzu1lbJ7+ceu2wDdcN3onEdUCTmKhi7g/ttesgssTYwtUSPr
	 rW+WF2gd2piFcXWd/vmDlQLLJL8H2xAn2DfHuoxLmEx6rnONeT6AmpMq8DIJ7J5hT4QSo
	 jyHP+jZXeObnxaHCaQX28a/brDbmBRXUrFpv6g2MRLwXxy05g/FeD1ooU3N9vcxmj/w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789316148;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Yy+yvzkm7Kak8g5V1T7y7vUUd32gcKiL29XJCPJce1M=;
	b=QhrXPjaDAnsq7GvEeFVHUzmnvGgP9Xf4fa+03pdlSx3MaQrtfpAQChRZhQHVZ77ehziY
	 ZE/PMH7yVy2dgRuGqwIgBhwkJa3cnzZ/YtFkXNfgIMHLIK4s/hnskJqRmemG25edCFHXV
	 6elZUq1WnB8F+EH22S1/R2ntya2gciCK5GPUXHnFcec80/M0cvJd3l1PppQnb4/tPgJOw
	 Fef+Hk2OHnhHRJFc2PV5HeeeLwCQ3rYDH8NwaCpaIFCm/ImU0w0d7T6W6vKBhy0cz1sto
	 N9yUTmdj7Vdzq0EyrnDosqjaPjOV1nZd4v6rArO6LFHNkPqMvmuWplVNhjNDIn4Q7iw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Thn9Oac4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789316148;
	bh=Yy+yvzkm7Kak8g5V1T7y7vUUd32gcKiL29XJCPJce1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UDlk7gidAoIVfaa6C4eAOi6CwVtkVcD96a3gWM0jRv0PQf+kqTDAV5CQBYIlwSr6W
	 iEuQG87zC7VEXM/1zqn0bpMc2AFaZOqbygLwJqtWr9mVxjY7PEJjmi4g81m0EZCN9a
	 fQfUpeG8XNueEvP+SlUVv7cRXXdgwfwR8Hl47fLMsVUSxg3HYjBXbO3Izp6Tfpn3lX
	 nMs8LV4fMUXDEBXHs7BGIMKI/GzZjxZ+LDXQSWfWcXUkLiAwgEB3GPSmCHoplzObH0
	 6L6rD7Rge5t46xr7ceR2T9BBLO3yIb0lIbDEatBHkeJJFZgp1KUl3dCUdvgMUctf+j
	 r7STiKx6Y+bDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC0DA605FD;
	Sun, 13 Sep 2026 16:15:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BE6833AF
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 16:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3907605FD
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 16:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SoZUGkRxuIaC for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 16:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8F804605FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:38::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789316146;
 b=KnCPc3kgocXrnsBVz57uckw8o6NT88QihXjIXB4qQMRRlWaRLU0qBU/veOaw0PDw+7ui
 TFkgHe8ltN5cMl5HYzMzbPKFVRnmo+Wz8VB+/r9LtLsP0Hz6OKsDxYhMFGLf6om/hNzrq
 Ppt52gtkT1I3e4/rZiyWE5G0s7lRUP5fYNUXmD20OdG5Si7p/9pY2cUAgwMREEsKLNCRj
 XOuWd6yxoFiIQ0B5H//EH5SzY21ZkrZbjRMJyI7wOcq7qJawO9OwyWqDGDXqsFhgVJOJ1
 hx/xUlB1OhRZ1gACbis2QADRvwPVtDkXQdZiswADGtMz3GxALbNpm3Hjp/oT/c8O+rA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789316146;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=Yy+yvzkm7Kak8g5V1T7y7vUUd32gcKiL29XJCPJce1M=;
 b=NmgFeK06GaqQpTfD/q/cFKglXAKxRnlzSEGpSt0wX/501kDpPYhhoIcE/4m25bus3o9T
 SoI90caQqPRYqbcIhYkY3dhN2pPoegnjUB5/DzWAnzWy5SazgGGe5Kbu0BPhG9d9oidRK
 I054jI8lE+Id65Ui5DJaSK8sRFTqLrNxlXQhJOhG5UcumuohjfrtgPy4bTzqaq42ovawN
 zPJL9WFTI+7FOI5kX5TuuCfxyDTi4CjOaScfWctT7uUZ+NXr67CqDpHIKEDMnyAf8nTEd
 f/BJunDBZZzvRInwhVaPhego8+gGoLOgtOr31GicvMOcEXG7tYAj7MQtneF03A7Qbjw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Thn9Oac4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:38::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:38::10; helo=mail-lr2-x10.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Thn9Oac4
Received: from mail-lr2-x10.google.com (mail-lr2-x10.google.com
 [IPv6:2a00:1450:4864:38::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F804605FA
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 16:15:45 +0000 (UTC)
Received: by mail-lr2-x10.google.com with SMTP id
 38308e7fff4ca-3a2ff148dfdso7496061fa.1
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 09:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789316143; cv=none;
 d=google.com; s=arc-20260327;
 b=VGUJlKxps8wrkLbrZ4qxDdMwwiXc4lZMXuUqJ04hP6hMcbbZGMUu3WZCBhs6q9Rx5p
 Tjflp7NbEgQ3Sfox+tMJECDKKxE2pkemLsFG+/HbO2TdIePoZcBsdY05beIDYI0E/Z5s
 za7Euu+RSgJWZT/UJfWVQRxdFGp6jIobm3jNxsl6FGDAraYDBY/NnoGrN+Jqor0dzouF
 Nm7G5aEPXA23Pa6dZYlbmKCOzh2bUTr4ybIrwwbZ3n+wYmmJPVuk8mnQ4ccerzJnQaQ2
 5oubVwe59SdCsrYjkD2PY/i1VqCqFr5Uc0Ms+GaeMp8jPCIWjSiya+59dt0ZgJfH/4rg
 xhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Yy+yvzkm7Kak8g5V1T7y7vUUd32gcKiL29XJCPJce1M=;
 fh=4qfuBcJCw0ZkoUEK0QKMTpMtEhoGZyq5f9QsLLkj5hA=;
 b=Jwy9T+lZFZMjKCc3a1Pv5J7S7kxAHUDgAime2GqFuud1UOIhI4ggCrZSDs26jLxI9F
 XqnnDDGKFQhQvxUd90on5vk0QonVaPdnSVHXA+yE83y9fkzNZkuGyv5V6yEFsyjXgJXX
 8whhzatxfc4iQIjZSoEVuH2JhZ80SubysnXDBkG25fycLtlsrmt/3U1XcauOAI0n79mA
 RkQwDQHsDIfB5o2Iho2gOxBi/9WStTh2lFTu3gDNSd0M+VLCpbCClVKF+oQfKguFuLZW
 urYlRmfBEibk+e4SWzUuy9iaDD8ndsjosAUKC664zXstqaUIaZlKkGAM/rNf9OhYuHA8
 HF8w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789316143; x=1789920943;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yy+yvzkm7Kak8g5V1T7y7vUUd32gcKiL29XJCPJce1M=;
 b=Thn9Oac4kwSiZ8uEkpHrs98vCmOm0GoGlU/NvNrp+7ggcSd7Cn1xD9ks/WOMNfpdXa
 4Gql9IMo9M530KmttULNRtxsqo2X2WM+KT/Q59TObwLmHhhVNCOg8sOa7pKfXo6iecUX
 Go/24BwamAoJAQK2wD3jFfVIQJEnWXwpT30Jpm/5FjlYGet1BxivTblbOkCqkY4Qac0Q
 HohoRP9ufVgFwxF+jA6/AWKHdVTpARzQN9VWD5AkyBDk7XCchqcsImflWt9Iaq9okgky
 3X17D8y9AHd5+iZHd9Xucw5YOrFmbZ5xnTn/MwseVRMfyeck2XcGAEPCDXF0nTHM/7n/
 X8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789316143; x=1789920943;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yy+yvzkm7Kak8g5V1T7y7vUUd32gcKiL29XJCPJce1M=;
 b=XsiCuykzL2jWEQ2SfYe0D6AvwPilL/vOrVo85l6YpPXJ054McJ1ovcvmoavT+6zRAw
 I8sabWFnM+bi8vlhh1lfnA+9tAR70dkphzwrDYe1zy7ZboPLv706gf7T0WWlxAcxDQrS
 6e0fEaLoWEl2z1N6yeOjW3IWJx6Y7V8AyhCo28Y0PxAqZuivl9zbU2hgFf63K1zeaAuw
 NWCsdS15p1vaNjTq4qiEHK/RFzNek6jhL+dTo5iKyFIUXiicNakLgAXYzXnt8lSlHBlK
 SulFYZX+Tv3kXx0OQWif/zl1Yrxjp37UJldRC85Yxmf4qodU516rVik5jh3TV3QV+jC4
 uW1w==
X-Gm-Message-State: AFuF++lppd4SwH0EFL3gI8SC35ntefkmNlY44O0HRNjHA6AmrOTojqO/
 Z8S9mGt7UqBfTFCx6GcLa6ZuP3JOJA0y78qy1OkJVinn9bkx6zwyy6dXg8ySxOh9LCG5KG4AwwV
 iwNh5K/+imwWQZfI8lcQ27hNU8EUdzh0=
X-Gm-Gg: AYBFou2BbGgHbRH9CODpeMTbZhkAAdPmA2bH7WdMVdu0ZKNxfXq8hf58IPn2eZM7m/T
 8+7zRAXx28lmRIUfWrsRQB6qoj6MdSClzfjAP9ZhemDKBHo23YEkPBdvEVyjnvzy7+23uXzURcD
 M4/gQnTgLTqhB7dYEybQiMQH0IBRQx3WkrI47QAREfO7h2AkuCmK6w2JuEA0keTVsMQHvOFn230
 OOFMrg0PCp6dfhPe8V1WMG2G/DMQr6UP1+tpwwne2PcfZpAEwJiw08ieEzfKRgNm32D3SDsPU0E
 gVZ8Ojoq+jclcKLVKQKNrUc8XtFBYeFL6Ses7ZYqfojzpCLrVuNLZffdNsQZnTq3g6ZceQg8YF5
 fprIMQGD3ShdlGCPXbKxPoZK/OgJTshvd6LyBa0kuXUfVrTUHR9xOKGY=
X-Received: by 2002:a2e:a586:0:b0:3a3:42cf:c035 with SMTP id
 38308e7fff4ca-3a5b3560f08mr8490561fa.2.1789316142490; Sun, 13 Sep 2026
 09:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260913155303.84201-1-aford173@gmail.com>
 <20260913155303.84201-2-aford173@gmail.com>
In-Reply-To: <20260913155303.84201-2-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 13 Sep 2026 13:15:31 -0300
X-Gm-Features: AcwNN1UYJDuETWb02ulaNPr3QqX8t6hT5fIhaNa16dJMvvVY4cTFXampsFx11IM
Message-ID: <CAOMZO5DV80JfDUyadp3-nbAYCLUT8tYroCGtdqkw+=b9LRxa9w@mail.gmail.com>
Subject: Re: [PATCH 1/3] board: beacon: Remove i.MX8MM Beacon EmbeddedWorks
 Devkit support
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Adam,

On Sun, Sep 13, 2026 at 12:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>
> Remove the i.MX8MM Beacon EmbeddedWorks Devkit board support along
> with its defconfigs, config header, U-Boot device tree overlay,
> documentation and Kconfig target.

Please explain the rationale for removing these boards.

Thanks
