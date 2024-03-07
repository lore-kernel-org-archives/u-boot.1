Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7462C48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 12:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A91187DED;
	Thu,  7 Mar 2024 13:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O/8Glvjb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBBE187E02; Thu,  7 Mar 2024 13:27:26 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8E087D6F
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 13:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-29ae0d292d4so54112a91.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 04:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709814442; x=1710419242; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaZHjM5ud2Ukv1BHID4q3Be2nXzVgLTkLVQ1nnTQ0Xk=;
 b=O/8GlvjbxiOiz8WzV0rrXWSxXO0F9qMvJKFa9jDj2Ixuo68W1Abypm7TKrLthkPqVF
 XWOD1LpmA8fuQon/KKdA2z63/BEPquHn01kd9THNut4lVLRdtXXtF5B/RkDVlS1oq07L
 QgxTDwtBPmXLZfOttuKd+MWyWWqxs2u86rTLV1vkeva6ZDG69IJcgK+AplXP5SEqP5c6
 zRakdglPIYJqVl7K/Qd7EHiBDI3oL7LIh4EEWIsQl9vb9YmdgeW4WHoVkMlerhCUKGE9
 ImFpfjhbSOxQ4S56dw1u46VXn0KJuBZoehVq5t6PsKCWvcZsac8tYDntyA7nwmphqNUu
 du6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709814442; x=1710419242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eaZHjM5ud2Ukv1BHID4q3Be2nXzVgLTkLVQ1nnTQ0Xk=;
 b=ZGESuIXVtAiMNFYWTFJ9ucXukOMEYebShj9ZiMiN7Ti6C+ZBUDWdWx+4Zgtbujz7m3
 JgRuV/AhBIQTqKD3j2vxyTo5ZP5QRya8/lmf5GMLpxJoMI3TvMj4jo39Sm5cBheXqnt5
 Tsr4B5I45NaZj29/9t++dOJFWjX2ythX+HjG+xJx1MDpHZZ7BxKSX/TGCSlbRL2AKuXT
 JN6ZnM8aHnpyQAmNfPhTu1T5knfdAWNIuyhThE+GEYqq/CSk5anNreDQ4HgAJlnC/bzw
 FcmrZ6ltBh0/yGG0iJVhxlgix7C/1SciGZq6xbR8mvxtG32R55iWs0dWm3trwoi3Nqgn
 KlNA==
X-Gm-Message-State: AOJu0Yzj1YdUxEO8Bzy341mgwNNj5OQgu14XCY69CtZNAUQLJB18bFYh
 w1QcVEiiDDMCJpY2VV4KF/jXSxfGHDW10HEriVP3pwq57oOUn7/SjpxEjvjyb2B+JRpiCiKzEFd
 WHRFexHCZJenQu09vDXRTBgu4r6c=
X-Google-Smtp-Source: AGHT+IHX7tyat7X9eGRhqnhIYLrvG5qIQcOY3u/FwYbx0gJbohfV3Iqiu0R4olJOlBbf1vQtS3acr1jqQ5o1yyhnpuU=
X-Received: by 2002:a17:90a:f497:b0:29b:8f83:82a3 with SMTP id
 bx23-20020a17090af49700b0029b8f8382a3mr1089423pjb.2.1709814441126; Thu, 07
 Mar 2024 04:27:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHnYusTGmUWt369vUmX3nNgkGttNd+bGJMen2=Gd7WQzZMTbRg@mail.gmail.com>
In-Reply-To: <CAHnYusTGmUWt369vUmX3nNgkGttNd+bGJMen2=Gd7WQzZMTbRg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 7 Mar 2024 09:27:09 -0300
Message-ID: <CAOMZO5DvbQS9Zqj2usA8c7aO2oehVQuL_0M6Z3OCwy3ymm+Rwg@mail.gmail.com>
Subject: Re: FEAT_CCIDX not tested when parsing ccsidr_el1
To: =?UTF-8?B?xYF1a2FzeiBXacSZY2FzemVr?= <lukasz.wiecaszek@googlemail.com>
Cc: u-boot@lists.denx.de
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

Hi =C5=81ukasz,

On Wed, Mar 6, 2024 at 3:21=E2=80=AFPM =C5=81ukasz Wi=C4=99caszek
<lukasz.wiecaszek@googlemail.com> wrote:

> I have already prepared a patch for our work related product and now I
> am thinking of mainstreaming that piece of work. What do you think
> about that?

Please send a formal patch via git send-email.
