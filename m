Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1B0FCC9DB
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 08:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1305083F9B;
	Tue, 10 Mar 2026 09:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q6A+Ujcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20ABE839DF; Tue, 10 Mar 2026 07:08:00 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1DC683952
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 07:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so11314019a91.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773122876; x=1773727676; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KYgLntiLiPRNUFobVL0qHTFFWccyJL+WpZWs936/9sU=;
 b=Q6A+Ujcyp/AuH9NLKvYLLeHPAkt4HXj2BF6fx3mglzPZpFHe7wO+FF8qtQzrfN2Bd4
 ZkzThiEM786okVkwLx3GoJ1APOMCMznIU8pPO17O9Q+q3T/ucGTv59tYfi2MHemRkdHb
 kkRhafOBO60jEMNHeLEs2OT/qzBN1b3rj1fOmfHcWRIIhTTJ/b3qNSav8ryDljMyYi4J
 NPsg0+AJRbIKW3S6l5uFTvT2gAcx7yMQZBkb6aWvQ2dvyt+cJs1T8DRvn0WmacBQD/UO
 m3cAQa3IFr5W1gpaPZM/rTD4TUOv+jmE7YaxO1EMTN1fhfHzYetEJ15lDK+H4nvw1mut
 JPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773122876; x=1773727676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYgLntiLiPRNUFobVL0qHTFFWccyJL+WpZWs936/9sU=;
 b=g4FwqffSxYNnvnieIF9wRl2+wVjoqEZrsW8WV42bEE/ko1NnlkwqDJZDpW/3OSxeVS
 oR4aq34Kcv7wQYKW6VRXbqJFadI6/ll8psdlgmODGfwgYTLQdWei0lt9vFvo9IRMBMDv
 3z+VWM1isveBMErfz9k32xMBhTZjUjjHnCsJd0GSA6bFMwb+wfYZjTkhsQxbwX5SZlTH
 OEj0XPhQ95au3X+aAeAaJZN4FtXVwZGwWFR3a0HsqMVCiKaTIMa9sSVYLEjiwwxJeCkR
 FLscNypkfJG6RgQOI2CB192fMhMCKMJY4pRVAJ2tx6cp3sEA5BpULidm4zvoQ5HU9vOo
 fkYg==
X-Gm-Message-State: AOJu0YxyGUjn6OAwyGFfaUIm8Mo+7HYp/UYDbOXqupeTxhphd7BKncWU
 l1w6SZFH/9YcQR1OWf/PQzmcZIm6KVH05Q7tyokGh9wDj39qb4xA1P3X
X-Gm-Gg: ATEYQzzTukyEzC+7CSekRdBCvF0YNM16/6FVwwWgGTZGpgcq9j8eaCOgF+XhA9lZYTW
 iFORPX2YBxA21OP0fTXwynuctfs5FZPWSeXt8OHuWvWV5HGw5QlOCZo+cX3f04E6C5cSIZSH+AB
 XsSyQgXk+K7kYJLQaLDeXUNHjqK089tmjYm55FcFBu22sC/dXAMup30m4a53yeCeeS/s1ifh0N/
 IqCv/8ASgozNDQGBdoAC5tpXslfkW6hCXjvhsXoqs6DMDG2ct+s6IMnUmlKh3jKZxx2x7FUqzTn
 WJXtCq8HfMzRmuSugPTUTfx1Qnb6dhIgEDtOPCcX1MI5qJwvf8gr21u92oe+MfQSDHYNEhgP0gn
 ufbczusvfyCWZAS0/80Ys4JKE+Ty5MhtT65yOB6zNzCo+oKSm5jm/OJKhehFGI0I0EWhY2Mk4Ka
 NEKr0Bg+X2OgAF1wzU3ghSKEpg4qnjvA==
X-Received: by 2002:a17:90b:2884:b0:354:a57c:65ec with SMTP id
 98e67ed59e1d1-359be3075femr11632485a91.20.1773122876276; 
 Mon, 09 Mar 2026 23:07:56 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:16a4:8f0d:6d1:8d9d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359bcbc6fe9sm4973433a91.12.2026.03.09.23.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 23:07:55 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:07:53 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] serial: goldfish: Add debug uart support
Message-ID: <aa-1OYXTCbsYImgr@google.com>
References: <20260309105110.672832-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309105110.672832-1-daniel@0x0f.com>
X-Mailman-Approved-At: Tue, 10 Mar 2026 09:36:34 +0100
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

On Mon, Mar 09, 2026 at 07:51:08PM +0900, Daniel Palmer wrote:
> Add debug support for the goldfish tty so it can be used for
> early debugging. This will be really useful when adding support
> for relocation to the m68k qemu virt machine.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  drivers/serial/Kconfig           |  8 ++++++++
>  drivers/serial/serial_goldfish.c | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+)

For the series:

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Hi Tom,
Would you take this patchset directly, or would you prefer a pull
request?

Regards,
Kuan-Wei
