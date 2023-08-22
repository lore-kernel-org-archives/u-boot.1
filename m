Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7928EE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 17:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54CAC864A0;
	Tue, 22 Aug 2023 19:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6319A864AA; Tue, 22 Aug 2023 19:40:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5AA47846C0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6D2B11FB;
 Tue, 22 Aug 2023 10:41:23 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F31D3F762;
 Tue, 22 Aug 2023 10:40:40 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v11 03/15] sandbox: capsule: Add keys and certificates needed
 for capsule update testing
Date: Tue, 22 Aug 2023 23:09:56 +0530
Message-Id: <20230822174008.626239-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822174008.626239-1-sughosh.ganu@linaro.org>
References: <20230822174008.626239-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add the private keys and public key certificates which are to be used
for capsule authentication while testing the EFI capsule update
functionality. There are two pairs of private and public keys, good
and bad. The good key pair will be used for signing capsules, whilst
the bad key pair is to be used as malicious keys for testing
authentication failure cases. The capsule_pub_key_good.crt is also
converted to an EFI Signature List(ESL) file, SIGNER.esl, which is
embedded in the platform's device-tree for capsule authentication.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V10: None

 board/sandbox/capsule_priv_key_bad.key  |  28 ++++++++++++++++++++++++
 board/sandbox/capsule_priv_key_good.key |  28 ++++++++++++++++++++++++
 board/sandbox/capsule_pub_esl_good.esl  | Bin 0 -> 831 bytes
 board/sandbox/capsule_pub_key_bad.crt   |  19 ++++++++++++++++
 board/sandbox/capsule_pub_key_good.crt  |  19 ++++++++++++++++
 5 files changed, 94 insertions(+)
 create mode 100644 board/sandbox/capsule_priv_key_bad.key
 create mode 100644 board/sandbox/capsule_priv_key_good.key
 create mode 100644 board/sandbox/capsule_pub_esl_good.esl
 create mode 100644 board/sandbox/capsule_pub_key_bad.crt
 create mode 100644 board/sandbox/capsule_pub_key_good.crt

diff --git a/board/sandbox/capsule_priv_key_bad.key b/board/sandbox/capsule_priv_key_bad.key
new file mode 100644
index 0000000000..2324f69ebd
--- /dev/null
+++ b/board/sandbox/capsule_priv_key_bad.key
@@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCmPw1pGd2xNW0p
+lesRXkkek3uwUB06Nt61tnZvpMkBKt4IokqGWz1tZls+Z2CqvwOfcsPZ27cPRYSu
+xRnM3YdL4MG6SePV7i/YSNw3rq8CP8zLGtCbNIfsfsNfPQEtPBpw6+7pMJKhjqpV
+2U2UQzZEiX4qlnhLpyv2JNJag27yf0feLdJi7HnJ9xdvcXpA1DSGm4y+DDhgYeI8
+DEteEu6s0TYQfnOZSQOeJi+1/Qz0S594uFJB37MyGh/mB15ILb8gva4nA3ayHOBK
+0dd+HSiUCGYrLYO7aj+nfzQj9N1qTlzCnC1603bMczU5pkwcODg6xP0Sn11J6RYy
+y0c0qzJLAgMBAAECggEABDY2MLoew3IkBltrParAWAUUcFLi95jw92q6BkOHEJg8
+2qia1yCitPUtPodMLmOKF5x4EdgXg5sv2O8MGbWP1VtUKXGh3QJcnRnNmsZ1hXJC
+RBcrei2aVLsqf0V2Mg3+GuG8PW3vLWHyZ/Sd6afeuXEYm2Bzrw9J5rfd3dBVKm7f
+HBvIyy1ATO/2cbUaEaCLOyhxLhssTI2TIK5SjlsjFLxiQXEi6RyGfBxUCriKZykS
+krMdvYh7Tf0uYcv0STmQ5s5Rd+RhRIGCVAdsNBxxJjgBAgqqa/B+kWbcc6o2D41n
+yWjErUaBBx3t0A7oT4K4DSTYwMNDVY3fhdd+szsocQKBgQDjnm8LG4UO6OQDm6iX
+0vTQTItoAz5TU6GEjHTCfVEqiupD4LKfHhSXwp2hRyzxXO5oNTU9MQCzYd7Npes0
+oVk4Tjo3YDacNPgxqKjODu/Q+tkTH15ydzGr674+YXHfCA1uT5GKOiiF0H1FZgMa
+Dk0s+3uWX34vbL4QCu97bUhBewKBgQC6+Z0J9sClgWvvjkglJN3XhRnAacp+WgX7
+bkpgSboXIIsqeqhd1WCLeV7L1pcZgifYBMPojf5LTBqBedL1q3RuqiqQWD/bSIYN
+Oc9KCdTjksS8Zo+w+s5zDObDhW9y13H2mKwDqilYBrT4fiA62wPMf1SjEF+RSC6K
+ZrQzHO1xcQKBgAILsXnLFIYOx8XUh05eAf9BQNt9c/jxvnjffkklMS6Nsw9LHK/b
+aFn40MvbROcia64aFFFpeFUkYwk8HYIKlS+xXEqVHciHnVds6Z94eOVK69qFJKco
+tRSTeNE8tPZJLz23j1pLrYOOXSHbidmZGU53MCQo1Yx9kLO6NW7Ji6WzAoGBALP4
+lEoE80Xbn3NEdvkZ1VcfzLvCmKCqMlvjuz+Xd8HPF2VaDznSq01VFAQMmAB7obJy
+U8hC9OSxakn6Yy8JS9dBgBrUdxKxaibM4FQZxosOuMPHzMPDhniDkJPemnnmGtIL
+/nbAkW8jdYpCjO9Z5PwwC92xYuvKmNGrLgSM8ZhhAoGAfgSZTpASXubM18E3ecfw
+5z333wf9qEQgZj7i9MzByFZudyHUhv/FPW1ocUJf36Wu1dfofZg3noSL6oakrm2v
+dFDo4PoyCStuF0w9SSzpIld01ZG0t7XqphY0DmshCXIXsqr7Vb4WrbBI7KX+b3Um
+BzmROfaSud97NjQ/RA26OZk=
+-----END PRIVATE KEY-----
diff --git a/board/sandbox/capsule_priv_key_good.key b/board/sandbox/capsule_priv_key_good.key
new file mode 100644
index 0000000000..9a37f59796
--- /dev/null
+++ b/board/sandbox/capsule_priv_key_good.key
@@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCwBfaV0P1jRzS6
+13U1T+4VbuMVsxFXhwHJY5z5Fx6v+cWBf3K1ruK+7cEnW55ZHXvNE2JCkjMvISKm
+hI/DLJWIPnAus8tFdU/R2u5oJbKI+b6GbuamO/CG9HsXZ58lOC6r2ckjixxovsA9
+SFshccdIv2YrwiVsWeyFpH+rB3/+cFbrgdWpaUc1367GkU/ZCnSRDBvVvzRRI1a4
+y2NogFqbZHXHENpzWNJ3TTXhf9dwM5HFGkmX7SA43Dtazae6CB4EaUKzLYWj3+ae
+AQbdvBrupKZQz1PUKn7X6+BGaLujHthvibYppNegPvqbJ1xBbv59CQK+lRULwC05
+NYw5+sIxAgMBAAECggEAHn8h/knjpMAw/BAZP//VrYP1Nwy7u/Dpl9U43JUrXWzG
+Uc3dd2nR4id6GBIRCLqJePnbQ9JlqMwyXyxHZhbC34SF1imTVbjh9+dY99VULdQr
+NMphDrsCzLbt3pu24HFv8Jk+dniDFwi5cMSo+U3nq4xxrLIp3rBjwLHD5sNZYyEU
+9xZnj7ziTn5X8da8iRxNpyzz2kQeVemJ0ahr/IkX718bkakSFMesGkln06vH7rAs
+069SeqOPrFEbWYXI5iMktLugl3JZpzasRE48j0M42PuProgvT7jb8B35ZF7kn0jT
+MqTIHglsJRWcSY0fAb2lHSAvd2vLLVunxr9PDWZvGQKBgQDVzVTuvo1CrVrQLy+B
+tpy2k5mjR3qxAOcoWTnKcMErLe8imWWaxukODenP4XqQIX4Sl+X3BXxOqun0Klap
+FEsI7TWSHf0eULFtFj0SCgqfRR+V/nblP05eO2nFXgr5YdNa1bWf/aMHplBo4q9e
+bbAr4InUB7IGWL2cWjhOhWuJbQKBgQDSw81cBM+vGPUYH/wlxlTVgZCo2Dg2NHjt
+LUBqvOZNr21j2F+w8t1vKmqwhkqpc5HIi3pHjEA5gZLTRtmf4GQyo973I6MGn4bS
+eayOd6/+FkAi9DUD+WaF7yctJqeevav6KF2UCiz78OtCAU5Y9jFFJpuOANIztI7m
+t7ZCUpMFVQKBgFnAsP7oj3SGQbFTnaXeeztKCx04TJExx9hwXIpXe0AdMF5d9wFa
+r0tvG9Bg34rSBJLZoXhpnR2JMl2FyIuCMV219t84J6IqTdF1nH2OKZdi9TeKc28Z
+fFSirGxmZkT6hDeFr5FScLYtY2QkhWomseY5hKK1+E4hwrd4SFruN46hAoGBAJgh
+nzTBgEtqH1enlrCJhSiLmihV0dVGcNb559pjuXTvoG0GfKPT2gPowRPkCzZe5ia0
+jrHgSWd44MtCA8nEBW8MG9+VyJH6Si3Yh7ZaLB2iX+8bCL1yow8f/c44bZtGW0F5
+K3q1EZ1VW+rL2IqcQhog8P1CGHgb514f0x3yTo71AoGACGdb+Nb6lg8OSJPUcuuH
+xsWk6RhkJl9bldTleS+QT3R9zO3FvbTwnCCYJboh5Cq/jVmiA7T+fcVAyEJNHSdm
+hxbHdScuiJdNWL9+FczOkylnKH3VEdG3RS5lGdyi6r+miTMs3h8WfzGp4JINysjg
+PUFskK36qGjASfkRUn0hizQ=
+-----END PRIVATE KEY-----
diff --git a/board/sandbox/capsule_pub_esl_good.esl b/board/sandbox/capsule_pub_esl_good.esl
new file mode 100644
index 0000000000000000000000000000000000000000..f8cc272309b2f80113c29e22bc9fdd5c767b4667
GIT binary patch
literal 831
zcmZ1&d0^?2Da*aux2_hA(f&|m&&&V@%1|1@gOCPI%=`vTjNcb9GchtTi3D3+YdNud
z!N;6d=3f<&F-6ONS4$i4vT<s)d9;1!Wn|=LWiSvk6fqEDV-96u=HU);4GxJ9_H_4i
z4Kh#==QT1murM$&v@kF?F^ZDlH#RUZHZ(9Wg9_l(*~F-XYzZSP19KB2KLgNRTue=j
zj0_uCzfHaHH`(1}*Y#3U|97H!k3}~NhPN}GOrG;oTyFi(qmA`NTh~3>_x7NA^t?#f
z>a)U0PLquF6_u8?^dHul+F@6qxB0YdssF`W?=n<3b^P4dmiKI#^@p}E)#B;%RW0;Z
z-#n?@Et9eDfUQTgV&QR*{b|~VRC6NVv@WS%&0hbnAnbMH)s>m<ruWw!o9KU&t7IaN
z^ws?)fy!Y!PA6wHM9oeqJuYyoIO0;duj#}3>jlOWk4kw?f2&||$2#il@?9KqESXN5
zbz2wTe>RVi?d~3_cT1K9oDaUDRd@aM1GkLbi{)<QcW%>Ma(#i_ui5G`j(PuTIhpoN
z73DslYiZhJ`RkA&6Eh<N<Kke0Km%D|xXbdfh_Q&secT;;BI`VRLX*$F#X3)yTwnIl
z%Rn9^t;`}}Al86g0Y6BAFeBrC7FGjhAcY+4z_<klJ0n9-ZF-^Byx1)aGPkZ;M8@iK
z@4h6QYApWke51U4vh|)B+RHfwcQh8f`Fd8-Ad#bU?mv#SCl^~!ojUbKMpn)-Kd>zH
z-bULy5-~dZsg>zZPS-w(zNM;c<#N4ar|5@t2FY2AoF7{4IWYI(=HR-Vl;VtSQGM$z
zG&LhNEwesN5|ez&@#Le<mt%k4Ngp{`oU3!I!!G(r+O78=mGAf;yBNLt_LaVmLHB2w
zF3Vp(*($;GmPMkjzjWQf=x-~Qozl?NwEilS|Lo7%xGP$f^Riek&1Q@!w>qJ9NJDsL
xX})Fc$L0Fj-&QP|CD!3Bu=aCF<a-t|<@nrhQ$HQy*tL7JV9T^r#)tp!0|2#rO&9<G

literal 0
HcmV?d00001

diff --git a/board/sandbox/capsule_pub_key_bad.crt b/board/sandbox/capsule_pub_key_bad.crt
new file mode 100644
index 0000000000..2e8e5d5828
--- /dev/null
+++ b/board/sandbox/capsule_pub_key_bad.crt
@@ -0,0 +1,19 @@
+-----BEGIN CERTIFICATE-----
+MIIDDzCCAfegAwIBAgIUWw3vHYnrjoHUXytxSm2eYWzbYVAwDQYJKoZIhvcNAQEL
+BQAwFjEUMBIGA1UEAwwLVEVTVF9TSUdORVIwIBcNMjMwODA0MTgwODEyWhgPMzAw
+MzEwMDYxODA4MTJaMBYxFDASBgNVBAMMC1RFU1RfU0lHTkVSMIIBIjANBgkqhkiG
+9w0BAQEFAAOCAQ8AMIIBCgKCAQEApj8NaRndsTVtKZXrEV5JHpN7sFAdOjbetbZ2
+b6TJASreCKJKhls9bWZbPmdgqr8Dn3LD2du3D0WErsUZzN2HS+DBuknj1e4v2Ejc
+N66vAj/MyxrQmzSH7H7DXz0BLTwacOvu6TCSoY6qVdlNlEM2RIl+KpZ4S6cr9iTS
+WoNu8n9H3i3SYux5yfcXb3F6QNQ0hpuMvgw4YGHiPAxLXhLurNE2EH5zmUkDniYv
+tf0M9EufeLhSQd+zMhof5gdeSC2/IL2uJwN2shzgStHXfh0olAhmKy2Du2o/p380
+I/Tdak5cwpwtetN2zHM1OaZMHDg4OsT9Ep9dSekWMstHNKsySwIDAQABo1MwUTAd
+BgNVHQ4EFgQUm9b8SnF811nweXSfGisfpzUHGwgwHwYDVR0jBBgwFoAUm9b8SnF8
+11nweXSfGisfpzUHGwgwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOC
+AQEAaOZFOcQzF1MRekcBmIZMaHSWYxOUrVLzBNSNhFD8muYiUAAufrkyTUq0Mmat
+w5hAnJ34VGpU1wxQlr/uwH7wpZZnGuj10rAp3tqES0g24AeH1bC9wmRs+rD6dcZR
+YmZq6FxtV7Cv3pQX7lhDYbcBj2za3YT6I1+yczskAHR6KYYuJzKJ7XRVCL7ZlYRX
+pUMZBQq2eAVWlW/c5iDT3KoGZUD9Of71F7qyUAqMMYafeDxguDz7gKstoXVCklQ+
+I4C7JKmRbrRvMgXx6O1clGhAsRZ0nNAtzi7XT5tD27qFwIPgwv48RWgsmPtzE03S
+YGQ5WhYMdHOOjWmcV6MDkCpiSA==
+-----END CERTIFICATE-----
diff --git a/board/sandbox/capsule_pub_key_good.crt b/board/sandbox/capsule_pub_key_good.crt
new file mode 100644
index 0000000000..82d8576a64
--- /dev/null
+++ b/board/sandbox/capsule_pub_key_good.crt
@@ -0,0 +1,19 @@
+-----BEGIN CERTIFICATE-----
+MIIDDzCCAfegAwIBAgIUUzrWhMi7oPFshQP6eFlccqf7exswDQYJKoZIhvcNAQEL
+BQAwFjEUMBIGA1UEAwwLVEVTVF9TSUdORVIwIBcNMjMwODA0MTgwNzQyWhgPMzAw
+MzEwMDYxODA3NDJaMBYxFDASBgNVBAMMC1RFU1RfU0lHTkVSMIIBIjANBgkqhkiG
+9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsAX2ldD9Y0c0utd1NU/uFW7jFbMRV4cByWOc
++Rcer/nFgX9yta7ivu3BJ1ueWR17zRNiQpIzLyEipoSPwyyViD5wLrPLRXVP0dru
+aCWyiPm+hm7mpjvwhvR7F2efJTguq9nJI4scaL7APUhbIXHHSL9mK8IlbFnshaR/
+qwd//nBW64HVqWlHNd+uxpFP2Qp0kQwb1b80USNWuMtjaIBam2R1xxDac1jSd001
+4X/XcDORxRpJl+0gONw7Ws2nuggeBGlCsy2Fo9/mngEG3bwa7qSmUM9T1Cp+1+vg
+Rmi7ox7Yb4m2KaTXoD76mydcQW7+fQkCvpUVC8AtOTWMOfrCMQIDAQABo1MwUTAd
+BgNVHQ4EFgQUHvG7Xchqzwdggky+oyzlpNem8UowHwYDVR0jBBgwFoAUHvG7Xchq
+zwdggky+oyzlpNem8UowDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOC
+AQEAUn1ncSqeXbQAHNrVOFldLwu70hNlMxf2z4EfH2M7vJgrpwkRuIFw7PXNITBh
+CImd/ghm5NGFysrK7BwdHkFvUXZV3rE93BhcLC9leWfky33kW9olIzpE14i5FfBn
+ABmaokPhOrzAneGzU35sZHNotlqOrzgpKVkpOWrykhYZ5Qjk8Sz0xvzuG8TJc20s
+2og+W8Rm2u/xI9xPxtFbq9vUjvFS35o1pm+vkzpgNdo4YS1PG37BW/aopsooLSk7
+9Rxv5vzNXtQqeZ5qBdKbAVh3OsgqwigTmXVvOX3xpy9r9qiimhaISxCt83RZ7wQW
+I19t9pXyxAi6u7MRhJZlAeH/3w==
+-----END CERTIFICATE-----
-- 
2.34.1

