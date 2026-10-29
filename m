Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829EF606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Pthybwki;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PXoGAbrl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CFAC80F6B;
	Thu, 29 Oct 2026 08:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KaJ-1yZbTxvv; Thu, 29 Oct 2026 08:52:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A339A80F6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793263955;
	b=Hb5UGF6H4nXE7zleKVLOutk0YsIVXaCzwTnO+FlvPXzD4Miysn0zvnPHaGirn9kN7BOY
	 NfwG8Tulsjc8RUeP5XRtLpfzvG7CjXH6WtLnVsyVOiT/6arB35O/1xsN/N4eVReYiiHFH
	 N1UM9djTv3GQFh/Vrr8g8q1TCNOAe1htql3wHXh/nrNM3FrDeEDprFrZzK1Zze4MQFw7Z
	 ar+hg8c6xf9fg9M0ji8mb8xcuYMGB/Go3imDsD5JfoY/DRb0Keon+1byyk/fupT01J9bR
	 QxJqAiW0iFtU9eIkGjQcnaGJJLlbGyEr2feLMW08HDX4/SUh1Q352+Qb8fKmT7ERjjA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793263955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 from:In-Reply-To:References:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=reuIqR8OzadVvfD1xymvpbvUyCs1lL8oLu+h5l6SC/w=;
	b=RKig00DvPzwC0GZnw6e8rMKTfh6YnsR8SwB3/EuD1OObMekCQncr16XyiT4KZ6oon71z
	 xTfi63bGQP3d16cDCNOQ1g0VDkEMjuIYkKmQc5W+QlQNYmkEN7fJMRfSZ1TF+TCwwb+Po
	 hrjYTxkXom4GxLWp6n9ZutetNN74pwceSG2NnjN/PXKQlJjnlOnA1VURyfVY+REOjoc3y
	 lAcVgNkwkcsHU7P+vRIjPrX+BiXuBC1NKGbc47xmiNg6flon9bvryhZajanO81fy6MX9f
	 XMzEUxsKACrKHNkpZSumcz0PCwXjaTgXs6LRUlt+xfnsukxpBzT3YfMflsHyfJF62Kw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793263955;
	bh=reuIqR8OzadVvfD1xymvpbvUyCs1lL8oLu+h5l6SC/w=;
	h=from:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PthybwkiX7QT9kQJNbbxj41YlPknwkd1Bp7gj90whyZbJsCkuxqmyNArQGlpYpXUB
	 c/jd3qi0hBx4yHkLXeWtt/0Gw5eqgPiLlhq0jDDPJQUO7f8AcmE9tdu4qSNPOcK4d8
	 9QQ1x8XnNRd4vetwnsIaKnWCiIiuR1P8nsdvyWCD/JIPl+Ln+61dU5Nd7rDW5GgRLZ
	 aEg8OR/FEMHJT2gOXlnD6j6oMHEtyw9tPfSWG0TMM1TQvNORsX0RYghnf9ZLp+pUQ+
	 RVSe3UAvy9CRp5iwFviyh3GOx5nFlXWHOlyli5gbcgjtSMnLCCUHt0vduYZBA9GT04
	 ZMC7U+8+J1iZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A339A80F6E;
	Thu, 29 Oct 2026 08:52:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF079473
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C12B26068D
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jGC8pnzjfzxp for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 08:52:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B454460677
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793263953;
 b=shbpWVybp5+zVpEmv/CtzVjnTmJBkW4Bj4BiLeRDrjG9YIVwMZ633yaagWujEB2b+VVS
 7CTn3oKIVHF6vqVJi/LazTwVNfgCxb0g3tlCMMkEjNvluxwxGJhU3grAYon5xyd7knXnl
 EFzA/2lYKjNrtns05QrwrXnykLTCdcdrZZtgr4+t5LshBIIywJF8BXeGyjjOwsc+nU5Ci
 g10R3rkpn/nnueHj7H8RyVK7BmhrTzjAweEEHQC+HTcIhrRXdrqfU7aP0Ql6vlceeJ5SN
 pyuQArxrERYGl9iziua4VtY9yXCcg/TGdpkgdCUTX+XF7f5vJsSNdXUN7Zpp54uP7zA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793263953;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:from:In-Reply-To:References:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=reuIqR8OzadVvfD1xymvpbvUyCs1lL8oLu+h5l6SC/w=;
 b=Dudj6in7At/ePNlbSrX4njkqQkfYPpKWkrlv5u3JS27ZjrjKDZ6qNBcWPLQkqnJkB186
 0Z3urGt45ntck9JcvG/ta12+9sM0CkyQGmscaCBm6ZRhQLp1ITBu88KLmsl3pfURAJ11C
 EzC81Q+ow5T4f9kS+u6pJXNnLu30BkpfXu9JT1WqPhe0HWqH02iBg18HUvNx4w4ogDnrt
 S3Kx9LCZHjisBgStmSrMjENuSyX31vZvDi1QBY/qfXxwwj2FucCsCCPwBemijnxNPXgHg
 Iyk8FQ/Y++y62AF2BfsW3zaV78IU8drW3wwBBqzbSlxIYxo/M7Sn8sR83HlWyd1Uvxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PXoGAbrl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PXoGAbrl
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B454460677
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:52:32 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b488586facso2427249a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 01:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793263950; cv=none;
 d=google.com; s=arc-20260327;
 b=ZeTf29EI/Z7XaCOWNzzfJA4gDfCpg4mOJJww74ZTUaS+p+PG8virL8uB46gW6qd3Ah
 7qeygTZlg6LeLE/bFiaWQSvWYITNOaLLMMEhd2JtDLFjdqqpdpfa9y/8cXi53tl0PT6A
 NwJLy90Phe36N34BUctty7Iw7laYMsaG6LH2O+4pNoaC/A70fEsNEo44RbW/ZcGTKq/6
 3u2T8AuMBzbSZ8SBiVKXl8iPDMLWPndbF5ThY2Lv4JPA2mx2jPPLrLgBoX9IpQO+YNoq
 oX0MPK4UYc2PLaO1W1QIZNaetFF/BqR6CD+ECLF4qfseY5nm3Db2jHjek+lstN+2Tbjn
 jVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=reuIqR8OzadVvfD1xymvpbvUyCs1lL8oLu+h5l6SC/w=;
 fh=MhH0YxP6QXh1SxcFORjWhLQE37pXWXdjDHcBbAqGpxw=;
 b=oIh6u7cxrqiZjbPe6FEUlNndcVJBKBIGKf+G8BWg8RcsSjdQ0Mx6rpPCiNMJe2R6EP
 Q3reK3XcAVeRv5oTV5+H/BIbdkawsdZaooqWx/eiT76vqotfddq1PdCC5UQzwb5Hhmzm
 //68rDUq8iZl41oH15bijt+TbmOYme5ecrlmdzNX0Ae+cjwLo2IjkEZzbNayExnRbGUz
 pdkRbsPArSv7O99MlQ4nfrv+w2HRLJwcG66kNjAn8foz5RRkncOE+IIcUiRyd2D2+NVw
 m+jcf8UXR4qTTzoW+v3DRbCr47M9nFfpGMroDM/T6cf19lymPbESSV49pxU2SOPNSL+e
 PllA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793263950; x=1793868750;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=reuIqR8OzadVvfD1xymvpbvUyCs1lL8oLu+h5l6SC/w=;
 b=PXoGAbrlSYz2h02Nz/gd79aOFGj3lIKh0V3SZ6H6XuIFK5i5DHp/QmDF1sapULdzFR
 /Xb+aSEUS/xskNlJEnkrLHwCj3Ez3vHx/DWvIbIi1Ka8NBl066XBGndNouVMzZnZUoqh
 ErM3bIQ8gri4bh5R4dA3SUoMEFSAtBpj5sdGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793263950; x=1793868750;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=reuIqR8OzadVvfD1xymvpbvUyCs1lL8oLu+h5l6SC/w=;
 b=y0LbNcdlPU+gSKIlznZUFqf1x73vmRFJ1I9Jtjux60daMV7Cmz74XcEJnXfulPhlCE
 +QNS4+IP+cs93U4WFIuJdojv6uDk5DGezut+3otyGvGurBhqKybaVRd+Oy6u+XRcxpWD
 kEt2vXsemnsUT2zVbprZsg+CLga2DMBVdKTcsU7QtUe6l6OUJF6+ZUlEBPLAOsFZxuBd
 CIWoQRYMyD1quLNt2kh192WfcpOX5xNDimAO9dVucWBX4ycDVPT2wlyRiaPVeZYF6AgQ
 wvB3RV8B/oOQaJaSZHJmTNtR2ArQbv5AlGNOYz0ugE6lo5uZeogCmbF/HO7s0oi32SbU
 dLsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxT8uR2aUZVU5KnLEjYnvzB+rFR8ymoBHf7CWkpnP2weQylxcZw7aLhr3wbG3QgIRZKzak4KA8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJePLVKNupmvLg3/DBKq5WPnlqwL+rsGsC3Z4B1jhxxLEieXXaA
 6DWrW6+TVNbfvMzbMuizSy+Rf7lEfDh5Vr0HVv6xIIPCIdM73Zl6mzq4uD+AxoTPWLOikwLJQe/
 wZ3RD5NGM6m4CKnH7Amu9rHzzy6QGN++P9//Gmt3dg1UIKMUmB7Cjdg==
X-Gm-Gg: AYBFou3cq/h4fF5l7tXo6iCPSEqgmuC65Tt31q4owREfZhWd7akOjw3h8Q4dHHMQZtl
 h4xMKMhR89PJXkC1ZXL6PMtw57lMpYC6ohFTd//7Tv8JCweb3uhT82PbJU3dJrk9yy9K3cZGc8N
 POwx5nRaSzCgfhW6kHzDmKjsAuK6VFUthNG1OMX7XqkUd5bQ89nE12EcOjR3ggegnRol8AV/ApS
 uZuI5dGuobLsW/hhVN2mVzTnqDmXDy3PqI1ikx5WyOzuX6zjHvOfeyV11NjpEA0BzmAYG4nnqUb
 WXbwP4uVsFNZ+Od3SC6qBCl1vN+3DYB2KF41e9gmIew4PgC6qNlHGik8yY/gAqqzadajvfYl5ec
 x+oW/FJpFcIsOL1nvdFkPi4XAsmiHD4mFpfc=
X-Received: by 2002:a05:6402:a311:b0:6b4:1cf5:2202 with SMTP id
 4fb4d7f45d1cf-6b49cbcf9d1mr2521989a12.12.1793263950323; Thu, 29 Oct 2026
 01:52:30 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 01:52:29 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 01:52:28 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
from: Simon Glass <sjg@chromium.org>
In-Reply-To: <20261028083122.2257868-1-juuso.rinta@nokia.com>
References: <CAFLszThz5iM4Qn78NOyVedon2jrDUnKn=0hN++YcFd1759tnPQ@mail.gmail.com>
 <20261028083122.2257868-1-juuso.rinta@nokia.com>
Date: Thu, 29 Oct 2026 01:52:29 -0700
X-Gm-Features: AclHuK8WVQ5PdWLQJlYtGHdEUZ8Q5kMJ_kumH9hOdvf-RgPWp0AfJypCN6dx6ME
Message-ID: <CAFLszTjS=6efc-Mup7byYmV-X8Kg96VrWV-P2-zTKdW0=4_ksA@mail.gmail.com>
Subject: Re: [PATCH 2/7] watchdog: warn if programmed timeout not longer than
 servicing interval
To: juuso.rinta@nokia.com
Cc: jonas@kwiboo.se, jonathan@joggee.fr, stefan.roese@mailbox.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org, yuriz@vodafonemail.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Juuso,

juuso.rinta@nokia.com <> wrote:

> I agree and would drop this condition for v2. But I think this goes a bit beyond
> Stefan's original suggestion ("once the uclass knows the real timeout it can
> warn"). For drivers that implement neither get_timeout nor max_timeout_ms, the
> compared value is only the requested timeout. Would you, Stefan, rather keep the
> warning limited to drivers implementing the get_timeout operation or drop the
> condition as suggested here?

Even when we only have the requested timeout, a timeout that is no
longer than the servicing interval is a configuration mistake. The
board will reset unless the hardware happens to round the timeout well
upwards. So the warning is still worth printing in that case. If you
want to be precise, the message could say 'requested' when
get_timeout() is not available, but I don't think that is needed.
Stefan has the final say, of course.

Regards,
Simon
