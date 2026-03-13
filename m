Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0E3105F793
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B919584253;
	Fri, 13 Mar 2026 11:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pm9RCRYW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA9B84262; Fri, 13 Mar 2026 11:48:48 +0100 (CET)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D62D8423D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64c9c8f8783so2389439d50.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 03:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773398924; cv=none;
 d=google.com; s=arc-20240605;
 b=Rz90lRFPQcqVxiOEFPcvK2NpsR5isSPHM81kRvBTf0EqvYUTYKtIs9s3e/1nBMuyRd
 j9LrUtwClYuYbeMdGfjlP/fiOBQxL43gMYEU/YXyu/GV5ur+cMH0BXqboxGt4eAzvy+M
 cp0lPBx4GScsY95Oa96F7s+4NMv/INN/+iD8wyeNVZ+nnulluzT9w+FVx3zBxmc0NeVp
 gL8nJ8KoQEJj1dmFWiWZfQRuenL6IHyGxp8vPCPIFBMTGEn1/uuY4nnZ90UeQdBjPjl7
 PW9Bp7xYD32UE1ZWqFhEqQu3c29qODDD14jgIO2rHZw885S6nxSNpP8DxmNRY8/gcS44
 Xpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8847Qtw0vUI7Xl3PI4H+4w+H0oPDLSGrdGB6+nNB1tA=;
 fh=wrhZen22MtbkREBrqvGymwuHbf+JYQB1yPUxtoA5vm8=;
 b=Rt7F0BYs0yyOhQPLUevDeb9sgPljSYqivy+We1VEThleYhsjKTNHp8tpbXijJpSJWa
 k2RXDctVu5S3aS9joiab7hXYyWKCBTRphPyKY1113rwF2oStG/pAEvYpf/6ilz8OoryY
 traXbL44oMvaPzlC3LJyD7WmH1KPvP70VJvI+aYNG/AHwg5RVQprrUVwWRnGJ5C3+Zty
 rbr4/4GaV2mun6UJj3pqOCajqKnvQLmB3j6ig7yCmTeMWqXG0SHCxYUK1MVb4Mh1Bz04
 eNJi+5yZpCoqqdlVtCam7LkV48XYewRvp8N7WqK+miAwGSqTZ5aD92DmnMyk6WjhE5qn
 85cQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773398924; x=1774003724; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8847Qtw0vUI7Xl3PI4H+4w+H0oPDLSGrdGB6+nNB1tA=;
 b=pm9RCRYWFCvlrSboVMX1c1gR4LbVb8M/VPL3OksuS/zPEqxPd/lEurWpJCQkqnqUtN
 2HiUs6CH6qSYNFOreKxrH/x55f7Q2W2Aa3ohX8S0U72Oiu+mpBkkyhyfpUvH5eVnDHb7
 P6l/Xk7YNIumyUdmVqVR+eDVHWztbkp4x77QdVgoUR7LW8V9+fUep2QAQrDLOj2sa7qb
 +CK+DC6G4I2Y4/MLAMlxXSR+VEHzOBOEW1cb+Wpg64Qn6qp23Ae4xIMFD7BK0QNtfoA1
 5arM/WLETk9irt3LY7DrmOdEYbdZbPzJP9edo790o46aOo5DUEgcGDnzYy2mZIydFLOj
 PZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773398924; x=1774003724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8847Qtw0vUI7Xl3PI4H+4w+H0oPDLSGrdGB6+nNB1tA=;
 b=bgEKp7XBLgPC3bqls36+Y7XICuOhwcc267uFCpxMzilqtvNu8q+UMP1IZ7wWw2DbAc
 gfEINLxSCVrslMD4Dt2F9EqEyEjKgTANv34YGN0Lm9mjIY5z9Ewg5XGovl9GcTNlGmTi
 +EdisvDJ0YZSI+CoRt8Na7dBaoXTjnCcRTkTTQ+WXkTcQOLJD+zVtmT0kwDg8qz3PnnV
 oPM/TSfGqXFcAbcKDmhOSsowJuby5qlNPHV9keRZnWkCsvgra/ezq9ceMVPY5hHC9Jnd
 LoYIkmAKZfX/A8UIYdpkl97uvPT9c+uMJxOlH/cJamA2/4uLJxbXbvB38L4Y9U9lnv5j
 TlWQ==
X-Gm-Message-State: AOJu0YyUb6M8/BczjzbRv4+q8ie0rMF1KoPCIbRkMEH4fxQ26+Ax+k5f
 08SLKmpGOMnc2/c68GXjIQzUt716Nqn1hUq8r8UvyS6MhdiNgK6F9adU49afikKaDvixvvpvbeK
 j485vq6gAC1zxa4K6GSYwGxakyCjUhDSaduEsyVy5Qw==
X-Gm-Gg: ATEYQzyfXgVPlhtzh3XfxWLVIkfU2zUV9WS5t9RdBLrAHmZmwRyv962ex271Qq7WKYM
 p3EHupzUXpAdF++Ar1yOYu0Wnb9uMavXyuwa4dGloiXQg8i1O0hw/b4FUsF+/ejpUbZlSW+ZN2A
 x79SLk1ppNErI2NeZsp/3I9JoIRMrrelg2slDqp7QXKOUgNp7ToSmH/s7yD8MoJqUeHMxeTYCMk
 lBUM24biIamlTMMSKiUZSNW8ihxolv4aNpRIYM4SwFj2u6raDZ5kIO+jMNtRSnsg/IfIMrU7D3f
 VF++xd1H5b6jkdkFYLO2wBAYLPyxnvqxevDDkwP7i1X6j2l4vmV+T7XHFVZnil/SrgSCY8gHdXJ
 /yf/89cAwt72HMPyMpdrk9PTGfwu45diKnd8TKDvjE8MCZ1odNPkelkZfBhznD5Ym5zfEfXh45P
 R52TP5bVa13t2R1t0Q3NbcwwdgC8zwbElBfIuByaoVssYuTpDGWzwIiRSXl/G7KK45U1hU1Q8f1
 QT+Rn/AZ6OqEkVzBgBRQ5HjoVn6JloVBCT46/VbKtQG7O+FwMwcw7xQqruVXdBqgfe+JA8cOIjp
 ClDEv4C7yO4zcP8NAA7lnzsWp8sGVQ7/NDq1yfbFkG4u
X-Received: by 2002:a05:690e:1485:b0:64a:effb:1331 with SMTP id
 956f58d0204a3-64dc717833bmr5814622d50.34.1773398924347; Fri, 13 Mar 2026
 03:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <00b03eb724de3e8b3e46ec630860e751bdc40011.1773322038.git.michal.simek@amd.com>
 <CAC_iWjL2OUZCvqAvEtdGHUyihsz6dekYsBYiP90Fi3wqz_H8yA@mail.gmail.com>
 <805030c3-4474-4f05-aa71-78b6c69a5568@amd.com>
In-Reply-To: <805030c3-4474-4f05-aa71-78b6c69a5568@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Mar 2026 12:48:08 +0200
X-Gm-Features: AaiRm50Pd0yJxF3YKkVEup19UMKJtxjs4_0H_YQyHEf7_3zCXBEnFNQzasn8O-M
Message-ID: <CAC_iWjKUjTe7Zg+guds249y3-hXSGEYSR1Byp4KMuv0BiVENfA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: avoid superfluous variable store writes on
 unchanged data
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>,
 Tom Rini <trini@konsulko.com>
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

On Fri, 13 Mar 2026 at 12:42, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 3/13/26 11:28, Ilias Apalodimas wrote:
> > Thanks Michal
> >
> >
> > The code looks sane apart from the runtime part.
> >
> > [...]
> >
> >> +
> >> +                       if (!memcmp(old_data, data1, size1)) {
> >
> > So this will probably blowup in Linux. We had similar issues with
> > memcpy and added efi_memcpy_runtime()
>
> ok. It means you want to just do comparison via loop right?

yea. Don't think we have a fucntion for it already. You might as well
add something like

int __efi_runtime efi_runtime_memcmp(const void *s1, const void *s2, size_t n)
{
         const u8 *pos1 = s1;
         const u8 *pos2 = s2;

          for (; n; --n) {
                  if (*pos1 != *pos2)
                          return *pos1 - *pos2;
                  ++pos1;
                  ++pos2;
          }
          return 0;
  }

Cheers
/Ilias
>
> M
