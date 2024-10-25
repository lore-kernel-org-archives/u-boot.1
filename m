Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCE2D0C61D
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D8E188FFB;
	Fri, 25 Oct 2024 16:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a6NYTOev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E77988B23; Fri, 25 Oct 2024 16:48:28 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 777A988A4C
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb388e64b0so22252321fa.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729867698; x=1730472498; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxRgZxV++9qcaG8pfy4yR6WdDGKeHYLhyP4uS8sNE/w=;
 b=a6NYTOevmqHt7+9RzwsqfEVpnCizR+UAmwpkM0LgOVjz9QYur58QzrxtEOQf3fwhRf
 PLa4hoP1fEnUu+D6zUmgshNQTQh1xXPma+64moxFBGzgi0xwDlFsRf0eWhLof5+q+FDV
 cc0/zPPnl7o6dIp2qcWHSa616h2X/AOa4Y5WNseI4/AOm6V/dQ+9o3Jm/g+cpM+0m0XJ
 tL9Khz0zO8HnJ3roBKEmrEiYSHSQTfLXtNU0nlfDy7zKPt93mNSnNtggUfFLGdjOWXmr
 OnT9yAsHrEhEZWTPOL3RRP9wTqK9t+Vfx1ySN8Ba072D5OQP1xp6kGw0czKSeRH32vOY
 rz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729867698; x=1730472498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QxRgZxV++9qcaG8pfy4yR6WdDGKeHYLhyP4uS8sNE/w=;
 b=FTbaOgelnsgt1jI3JVEwmyO7GDZn0PWVjppzb8L4wdnFS2V8s82OfmJzJaX2YU73p+
 mkUuv06UpamEByE0sLqfANuwJfXlg0qbyjrxAeYheC/qB3lm+OlhXOMZUhPi1Kv5aRb0
 S5fKkFk1m6o4GFLhH6P9ylfzzrGHOyJoYrmFhRwulwY478xkLAWAaVj25jzDyWqsQSjy
 zNbGwrR6GEO1DPuR4WLwvipSO8/NZLeI9I/iZOZlyRlezY5ootYh71jlHI+kGbDGLWcn
 haQayPF9/PvDIgpaOykFigQnwJp7CKXURZifbqSsx8y8BjCFByQISETvv+v7bAiItC3H
 LOew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfrMZjim9mOs0zk+EuU7GpgCirsIaOfRGbwvv/WF0NijwbOGmB89Rt9/mS+38SVf4ccsuPNuE=@lists.denx.de
X-Gm-Message-State: AOJu0YzUoYK0q6BE6JdW5+UXeJBbnCh0F4VSIKWokApczIQoYrlA7wAQ
 affVREW5uyRN0loIhXO/bksyX47qHsklCDPHNCThK+EU6KIFA2ILq/8l5eb0t5xmZC6nHo3rc3D
 z1qAJu5mw+MZcevkgwgJi2wItzjGAxw==
X-Google-Smtp-Source: AGHT+IF21SPtPvPYijkUQ/HlMXpfgFeQkf6MXjXzyZFbAWZxdbqF4IvXRuZadRPBH1Sz6prVs7h+5z/UM3RMWVsNU+0=
X-Received: by 2002:a2e:a9a6:0:b0:2fb:565a:d93c with SMTP id
 38308e7fff4ca-2fc9d33a85emr58486791fa.1.1729867697592; Fri, 25 Oct 2024
 07:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241019005125.4165-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241019005125.4165-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 11:48:06 -0300
Message-ID: <CAOMZO5AwpKyYyTgWKqx_pr0Q1OB8CzPekPAR93SOU02dgHvoWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: imx8qxp-mek: fix boot
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, uboot-imx@nxp.com, 
 Peng Fan <peng.fan@nxp.com>
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

On Fri, Oct 18, 2024 at 8:47=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> serial_init runs into panic because no serial device found.
> Update the device tree to include bootph-some-ram for some critial
> devices needed in pre-reloc tage
>
> Fixes: 8c103c33fb1 ("dm: dts: Convert driver model tags to use new schema=
")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied all, thanks.
