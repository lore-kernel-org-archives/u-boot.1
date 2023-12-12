Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54872C4167D
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC44C86EF1;
	Tue, 12 Dec 2023 17:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EdMl0t9C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 404CD87839; Tue, 12 Dec 2023 17:15:54 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2918A804CE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28ac13259afso171985a91.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702397750; x=1703002550; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHs0FPpbFezBPWyafHsKt39nLC2CJ7TIrzGqtuNSVzg=;
 b=EdMl0t9Cyp9gBgIWlNlGYn9nFf9+DWeLEKBSZQD/dqCod38rIgnZMiJ4kkALynwCrm
 yCDuYN452Qar9ZlUaeF06y1XE+i+U7ELTPewCi2uwwvJex1GTzo6mOrjhButihYXtMSs
 0wtj4C6ZeRNZulGXuSRcIIRJ3d/FDJtA7DWIyPLyuZEj4Fursqxh+qqzZfqpC8MOQk9M
 qLaK2EKO/+zGNGuk/Tz7+HVvwrqIpQuafaQokSn8MIzl1V9BZDQ15aqtmZpKZ6nDhtsE
 2fA2AGhwIDcTp3pvaTyiBCKy17HBXIsILFHPUDY85+t0fZDWfDLc2P7k6eaxPjbHcWE9
 1XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702397750; x=1703002550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lHs0FPpbFezBPWyafHsKt39nLC2CJ7TIrzGqtuNSVzg=;
 b=iwqeVokUXnuZkdGU4J/r4YKbYj1NkGNMVeAvjpD6SKbS4jAoUbiEp0q/SgzIim9AsW
 1eDBN+087+8sZkAsZ4/mV0yjkFBfIIKVdUwLOX4TL/qf7sOPrMBQANl86O4HkZmtuAhG
 zGQgAWbQQ/TeMMXpReIONhUK9xYNJYKVX8j8gFYl/WwF82NRmclvtIo/7/hdfJYh9uKj
 aGjq30GhtwUOZ9kOlZSkv4DLMNjyUVS9RM7YjmA8cmuMmBDDKy2hX7378texqVAs8BT2
 cOkL7UcOHhjbnGxJxXnP/mpF2hg19BdiuYFLfwKcCFcKUyjlAGizn2F8+zesDJRpRdOA
 Au9Q==
X-Gm-Message-State: AOJu0YzaD3RtnH2aZDZe0lrI1ZP5BnGTNrSqjsSE7AGEf8waOW30L1lI
 g493HK3Gh3HGNFD9PbbMVrycP7NVzXUtF6e/No8ep/Sn
X-Google-Smtp-Source: AGHT+IEkcXmghyQKBhl0jJpGcZQVTQUuO7rKCUREOgy2HV1CPaACwGce9gcTUfs1qlFiKLAOWqiSn8RRJLHfvxlrnhs=
X-Received: by 2002:a05:6a20:3d07:b0:18b:3c9b:f196 with SMTP id
 y7-20020a056a203d0700b0018b3c9bf196mr16245920pzi.1.1702397750462; Tue, 12 Dec
 2023 08:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20231026121636.3227582-1-festevam@gmail.com>
In-Reply-To: <20231026121636.3227582-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 13:15:38 -0300
Message-ID: <CAOMZO5B9UbwmVKZEZz+jD2OEVw=KueYFQOJKS4GYq9mr1-O7xw@mail.gmail.com>
Subject: Re: [PATCH] imx8mp_evk: Select CONFIG_NET_RANDOM_ETHADDR
To: sbabic@denx.de
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Thu, Oct 26, 2023 at 9:16=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> On an early revision of the imx8mp-evk that I have access to,
> the MAC addresses fuses are not programmed, causing failure to bring
> the Ethernet interfaces.
>
> Fix this problema by selecting CONFIG_NET_RANDOM_ETHADDR so that
> random MAC addresses are assigned and the Ethernet ports become
> functional out of the box.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks.
