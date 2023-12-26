Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3013C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 10:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3BA387786;
	Tue, 26 Dec 2023 11:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="I644c4B8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D55C7878FF; Tue, 26 Dec 2023 11:41:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E392586EF3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 11:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703587303; x=1704192103; i=xypron.glpk@gmx.de;
 bh=9CW/SbD5+XkRj70W+yDamOHQgar4q5+BSgmaDY08JME=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=I644c4B80/a9LtzEJ2YUX+gSkj9v1vbixKS3gbiNdltZTtTj7JVL5QOD8E21NwMI
 ute4bPOvo+16M0xxkUVmCD2MjE9HxH6/XdHlu1jjwrlwbCyveoyrUOt0BNd3Auuo7
 a//NmlMqviJ8vgZExAK0RslRTU+mb/w/mOGpmB4slaXi0w+nGmmlzPjxStltRogHK
 d/gnKcqj5FaZkz/3GraeAfqrb8a3sCpak7l50RAeVxBsGQMZ34nyqdqI0xDq+zLph
 Z03gjS0vZVBX/nkV193rsC27IMHRGvCtqrLjgDeRCcQyZooyzJ4YsOcmF7sEnjs1s
 S2GI1TkgxFbHTGA0RA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.152] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1qzIRW3sXE-00uGso; Tue, 26
 Dec 2023 11:41:43 +0100
Message-ID: <a22aa340-d355-45bc-a920-6b95f38a6364@gmx.de>
Date: Tue, 26 Dec 2023 11:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] smbios: Refactor 32-bit code into an else statement
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-2-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231015024511.3995580-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HljurtiubsqdGe4xKjtN6aPWoKdJ3WhUgsG/OJYCkEWUhcKO7oV
 aHQGKbjmvfYHenI7Ax06Wluq8OGpmJ0eDTBbxpKS76aUafB+dMa132hFd4mR191F84H9Xds
 7K0YN3XkgRvc1ox45LWDDjdQjC2ANHNwu5rbPVY4+NSHhXCppiOzq3sMpCQmP97TMYUlaj9
 teJlJJCn6V+70V+MsK0+g==
UI-OutboundReport: notjunk:1;M01:P0:0DUWGKPdsvY=;TSv8iMNwwDmj305YjcpfhbLsPuB
 xD71d0qD1pLpfUNjdimsJ1rjjHxisaN7lazqKHqm+Bs1pjHmDCEYpP1tzQPiiXjehPk3WCIZy
 GFS5oXNFMLJHJKLmSX9vh3Ki56uvTHDxP09mTTvYb2gb2wWNOYci3L0UuOjx/AuhhAJqM9RjE
 J+DvloaPwi53VhCrlKbFpA5lRz3OWLVj5LrmU9SQh0R80oM5HciybzYXZy1hXn5IFWQbzq1br
 LY3T4GrJlXMxBmBASy0AYZeXbfYPzVdvR6dfnFVLUFvTLP3q5Wqy6nOPcfqdkx8eYCkmJGZXf
 u6W3GAqPTDZlXe/runHGHr2lza8B6CjDyQauVAJMDlthupic/3GmHcY+nsxJhQ9StwXodWtDg
 h5rBGo3n+Rax4GO7TwIBfzmWW3U9PtXOnWAXvm8ZBAlWYlGbiyBWig0lNsC+8MbAuYoNTdMh1
 F2ygMXbQEyVxrBhNznsXtZ0OBnRABFHCaedmU0CFn22m5vNM4XuDXyKGjhLUexzhz7bZSYWmX
 67WTUZENUpCEe5WCC2UXZdSghUtVEjfw0L9JX+LmwPm3s8y5GueOUuFneemrUG6hUUNQjDfxO
 PUKsM4caNMzqPDVP4DVP0uejga8r3gtj6mOMYEfjAK7+W0TaJvN5UHCx32V5iJwR51I5Wd8D+
 uv2C+GTwEyDPg6iYtER3dWMnmt21n/W6IHt4kp9Rd0rVNzJnywBNbnF/5sRKyVKse64LVkJTI
 Fb44wBxvWTUDHDtN9iLZCAuprK6u6T/ZesL5UMYoNfQd/vbxHV7xdrz4m0nnbnv8x60YkdE8G
 Ez3rP7aUOmFAKvjlrRECnQ0jNbIrc0OhrMma1av6gljYs5JFZNxAxdMDafeaIRWyIr57GNEQY
 D884u2fZ85qviT5VJ7Svwah+LPXAj6I3xhmUnMDjCPhqH8oFfT4xjJlorj3wTLBrOxwSCbQcj
 qnLMtyYTH/K2VkU6Ji3JBJqwaYQ=
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

On 10/15/23 04:45, Simon Glass wrote:
> In preparation for adding support for SMBIOS3 move this code into an
> else statement. There is no functional change.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
