Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9E8C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C948801F;
	Mon, 15 Apr 2024 13:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RKrGrF5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A1F87CB7; Mon, 15 Apr 2024 13:02:10 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A4A088198
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ee0d5044e6so408775b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713178923; x=1713783723; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33GmXQQMOzY2WbJ9V0fmhkT8vZGSINlwHXMUbVlpXgA=;
 b=RKrGrF5RmURwqCwPhYOy+wCMzsjFNU8HsrPcStpOcB8k0lzHzBMH3LW7QKLy87rVJj
 pBAkQusXn/80khoPHXzkhAjT07bxkYQcjwAsxgzfsIdiVx+mvq/CbqwTVFt8NqGE1nfj
 f9ddQdGZGdi7R7fzDv3PJjP141+gru6d19DRiEOy9q8kgrjvCjsc7uq9dexONiM8xeiz
 BnlnKY9LqFdRro33TPzxc1BB6WMKbaj3Cf+NAhyrwasOStpQMEFSpoLO4OUQbo4HVcKu
 cPXSG50baoU5efYcYMrv1EK1tJEKj3npMZ3bdASNJsV6SWq3mxeM71MeJNXeWJ8mcaUC
 w86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713178923; x=1713783723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33GmXQQMOzY2WbJ9V0fmhkT8vZGSINlwHXMUbVlpXgA=;
 b=aEPRTFbposewGAhXKQ/IF8lnBRuC6JvMo6ElBciZHIQ6PpcSbI/k1aU6GFwWW/5Icz
 iD3v45anTB7lrS9lsWINsPA96zNGLIllclpXJPa2bJ2vqX2B2SIb0kwieMwYxBZsBss/
 Qb5ObRnULwCGyV7o4/fUeMNlXJxzy8LsvEeWD6wVIEGU6zD+c9MTlFRle7Y0pT4lZKKu
 0pHvkAv2a5tHJVHbDfOueW+KvxieR1C4pcXgztzQ3MJgrOTlt698gJ6mdf72C6XQKqXo
 X2p7c/kRIaP7+P6NIaMb0eK/wHwKYvMlZewfVAh3Ronr+jax4MEKkZ/Q8qoUZ0t18ogo
 rShA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVefg+lRrjWHKUBggjU0Vx8ogJ5VvipCEFw0QnLUcw8I6xXSrvt9qSYbbRvTh0cH3RYDA9Fh4b5Iud+jkRupwjE7VxJnQ==
X-Gm-Message-State: AOJu0YzihbA22FMzlrw3gNTg9srSFlxgGtpSYhQHzu39UTJJfPeAMLni
 f8G5YAfB3DTRL5OsnIurL4iGIe0zVMemZLO2O0QaSrsNze3xpJEcGRH5oi59ngwx477XSvN3OYE
 TngTSu2yL9s6C4kWbE0M6jC0I0v8=
X-Google-Smtp-Source: AGHT+IGnKkYQXIKwQogJCaDDW7mPB8LCITxnVEjWJ/glJtTdnYj3jobOqhbsGLHoGFyQeoUoObwY/IYbPSxQUYhOxSU=
X-Received: by 2002:a05:6a21:789e:b0:1a7:91b0:9ba3 with SMTP id
 bf30-20020a056a21789e00b001a791b09ba3mr12323552pzc.4.1713178923141; Mon, 15
 Apr 2024 04:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240414104607.5966-1-yasuharu.shibata@gmail.com>
In-Reply-To: <20240414104607.5966-1-yasuharu.shibata@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 15 Apr 2024 08:01:52 -0300
Message-ID: <CAOMZO5D3cqhFVQoNbSF=EtBfOhTQj_L4wDMtd2cVf1ut35BrBw@mail.gmail.com>
Subject: Re: [PATCH] net: wget: Support retransmission a dropped packet
To: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Yasuharu,

On Sun, Apr 14, 2024 at 9:46=E2=80=AFAM Yasuharu Shibata
<yasuharu.shibata@gmail.com> wrote:
>
> The server sends multiple packets without waiting for an ACK
> by window control and if some packets are dropped,
> wget will return an ACK including the dropped packets.
>
> Following log indicates this issue.
>
>   wget_handler() wget: Transferring, seq=3D97bbdd4a, ack=3D30,len=3D580
>   wget_handler() wget: Transferring, seq=3D97bbedca, ack=3D30,len=3D580
>
> First packet of TCP sequence number is 0x97bbdd4a.
> Second packet of TCP sequence number should be 0x97bbe2ca,
> however it is 0x97bbedca and returns its ACK, so the server
> suppose that 0x97bbe2ca and 0x97bbedca are received appropriately.
> In this case, 0x97bbe2ca was lost and the data of wget was broken.
>
> In this patch, next_data_seq_num holds the next expected
> TCP sequence number.
> If the TCP sequence number different from next_data_seq_num,
> trying to retransmit the packet.
>
> Signed-off-by: Yasuharu Shibata <yasuharu.shibata@gmail.com>

Tested-by: Fabio Estevam <festevam@gmail.com>
